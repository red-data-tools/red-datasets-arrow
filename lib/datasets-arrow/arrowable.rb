require "arrow"
require "parquet"

module DatasetsArrow
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
        raw_table = {}
        @columns.each do |name, values|
          raw_table[name] = Arrow::ArraryBuilder.build(values)
        end
        table = Arrow::Table.new(raw_table)
        Parquet::ArrowFileWriter.open(table.schema, data_path_raw) do |writer|
          chunk_size = 1024
          writer.write_table(table, chunk_size)
        end
        table
      end
    end
  end
end
