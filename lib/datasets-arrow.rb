require "datasets"

require "datasets-arrow/arrowable"

module Datasets
  class Dataset
    include DatasetsArrow::Arrowable
  end
end
