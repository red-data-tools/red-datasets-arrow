class IrisTest < Test::Unit::TestCase
  def setup
    @dataset = Datasets::Iris.new
  end

  test("#to_arrow") do
    assert_equal(<<-TABLE, @dataset.to_arrow.to_s)
	sepal_length	sepal_width	petal_length	petal_width	class
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
end
