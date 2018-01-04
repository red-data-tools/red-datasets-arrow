require "arrow"
require "parquet"

module DatasetsArrow
  class ArrowConverter
    def initialize(columns)
      @columns = columns
    end

    def convert
      raw_table = {}
      @columns.each do |name, values|
        raw_table[name] = build_array(values)
      end
      Arrow::Table.new(raw_table)
    end

    private
    def build_array(values)
      builder_class = nil
      values.each do |value|
        case value
        when String
          return Arrow::StringArray.new(values)
        when Float
          return Arrow::DoubleArray.new(values)
        when Integer
          if value.negative?
            builder = Arrow::IntArrayBuilder.new
            return builder.build(values)
          else
            builder_class = Arrow::UIntArrayBuilder
          end
        when Time
          builder = Arrow::TimestampArrayBuilder.new(:nano)
          times = values.collect do |time|
            time.sec * 1_000_000_000 + time.nsec
          end
          return builder.build(times)
        else
          return Arrow::StringArray.new(values)
        end
      end
      if builder_class
        builder_class.new.build(values)
      else
        Arrow::StringArray.new(values)
      end
    end
  end

  module Arrowable
    def to_arrow
      data_path = cache_dir_path + "data.parquet"
      data_path_raw = data_path.to_path
      if data_path.exist?
        reader = Parquet::ArrowFileReader.new(data_path_raw)
        reader.n_threads = 4
        reader.read_table
      else
        columns = {}
        each do |record|
          record.to_h.each do |name, value|
            values = (columns[name] ||= [])
            values << value
          end
        end
        converter = ArrowConverter.new(columns)
        table = converter.convert
        Parquet::ArrowFileWriter.open(table.schema, data_path_raw) do |writer|
          chunk_size = 1024
          writer.write_table(table, chunk_size)
        end
        table
      end
    end
  end
end
