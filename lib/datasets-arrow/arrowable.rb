require "arrow"

module DatasetsArrow
  module Arrowable
    def to_arrow
      data_path = arrow_data_path
      if data_path.exist?
        Arrow::Table.load(data_path)
      else
        raw_table = {}
        to_table.to_h.each do |name, values|
          raw_table[name] = Arrow::ArrayBuilder.build(values)
        end
        table = Arrow::Table.new(raw_table)
        directory = data_path.parent
        directory.mkpath unless directory.exist?
        table.save(data_path)
        table
      end
    end

    def each_record_batch(&block)
      return to_enum(__method__) unless block_given?

      data_path = arrow_data_path
      if data_path.exist?
        input = Arrow::MemoryMappedInputStream.new(data_path.to_path)
        reader = Arrow::RecordBatchFileReader.new(input)
        reader.each do |record_batch|
          record_batch.instance_variable_set(:@input, input)
          yield(record_batch)
        end
      else
        to_arrow.each_record_batch(&block)
      end
    end

    private
    def arrow_data_path
      cache_dir_path + "data.arrow"
    end
  end
end
