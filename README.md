# README

## Name

Red Datasets Arrow

## Description

Red Datasets Arrow adds [Apache Arrow](http://arrow.apache.org/) object export feature to Red Datasets.

Red Datasets Arrow adds `#to_arrow` method to each dataset in Red Datasets. You can get dataset as `Arrow::Table` object. `Arrow::Table` is provided by [Red Arrow](http://github.com/red-data-tools/red-arrow).

## Install

```console
% gem install red-datasets-arrow
```

## Usage

Here is an example to access iris dataset by `#to_arrow`:

```ruby
require "datasets-arrow"

iris = Datasets::Iris.new
puts iris.to_arrow
```

## License

The MIT license. See `LICENSE.txt` for details.
