class IrisTest < Test::Unit::TestCase
  def setup
    @dataset = Datasets::Iris.new
  end

  test("#to_arrow") do
    assert_equal(<<-TABLE, @dataset.to_arrow.to_s)
	sepal_length	sepal_width	petal_length	petal_width	label
  0	    5.100000	   3.500000	    1.400000	   0.200000	Iris-setosa
  1	    4.900000	   3.000000	    1.400000	   0.200000	Iris-setosa
  2	    4.700000	   3.200000	    1.300000	   0.200000	Iris-setosa
  3	    4.600000	   3.100000	    1.500000	   0.200000	Iris-setosa
  4	    5.000000	   3.600000	    1.400000	   0.200000	Iris-setosa
  5	    5.400000	   3.900000	    1.700000	   0.400000	Iris-setosa
  6	    4.600000	   3.400000	    1.400000	   0.300000	Iris-setosa
  7	    5.000000	   3.400000	    1.500000	   0.200000	Iris-setosa
  8	    4.400000	   2.900000	    1.400000	   0.200000	Iris-setosa
  9	    4.900000	   3.100000	    1.500000	   0.100000	Iris-setosa
...
140	    6.700000	   3.100000	    5.600000	   2.400000	Iris-virginica
141	    6.900000	   3.100000	    5.100000	   2.300000	Iris-virginica
142	    5.800000	   2.700000	    5.100000	   1.900000	Iris-virginica
143	    6.800000	   3.200000	    5.900000	   2.300000	Iris-virginica
144	    6.700000	   3.300000	    5.700000	   2.500000	Iris-virginica
145	    6.700000	   3.000000	    5.200000	   2.300000	Iris-virginica
146	    6.300000	   2.500000	    5.000000	   1.900000	Iris-virginica
147	    6.500000	   3.000000	    5.200000	   2.000000	Iris-virginica
148	    6.200000	   3.400000	    5.400000	   2.300000	Iris-virginica
149	    5.900000	   3.000000	    5.100000	   1.800000	Iris-virginica
    TABLE
  end

  test("#each_record_batch") do
    assert_equal([<<-RECORD_BATCH], @dataset.each_record_batch.collect(&:to_s))
sepal_length:   [
    5.1,
    4.9,
    4.7,
    4.6,
    5,
    5.4,
    4.6,
    5,
    4.4,
    4.9,
    ...
    6.7,
    6.9,
    5.8,
    6.8,
    6.7,
    6.7,
    6.3,
    6.5,
    6.2,
    5.9
  ]
sepal_width:   [
    3.5,
    3,
    3.2,
    3.1,
    3.6,
    3.9,
    3.4,
    3.4,
    2.9,
    3.1,
    ...
    3.1,
    3.1,
    2.7,
    3.2,
    3.3,
    3,
    2.5,
    3,
    3.4,
    3
  ]
petal_length:   [
    1.4,
    1.4,
    1.3,
    1.5,
    1.4,
    1.7,
    1.4,
    1.5,
    1.4,
    1.5,
    ...
    5.6,
    5.1,
    5.1,
    5.9,
    5.7,
    5.2,
    5,
    5.2,
    5.4,
    5.1
  ]
petal_width:   [
    0.2,
    0.2,
    0.2,
    0.2,
    0.2,
    0.4,
    0.3,
    0.2,
    0.2,
    0.1,
    ...
    2.4,
    2.3,
    1.9,
    2.3,
    2.5,
    2.3,
    1.9,
    2,
    2.3,
    1.8
  ]
label:   [
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    "Iris-setosa",
    ...
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica",
    "Iris-virginica"
  ]
    RECORD_BATCH
  end
end
