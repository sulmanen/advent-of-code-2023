ExUnit.start()

defmodule SensorTest do
  use ExUnit.Case, async: true
  import Sensor

  @input """
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  """

  @difference difference(List.first(read(@input)))

  test "read" do
    assert(List.first(read(@input)) == [0, 3, 6, 9, 12, 15])
  end

  test "difference" do
    assert(@difference == [3, 3, 3, 3, 3])
  end

  test "difference non zero first" do
    assert(difference(Enum.at(read(@input), 1)) == [2, 3, 4, 5, 6])
  end

  test "difference tree" do
    assert(difference_tree(List.first(read(@input)), []) == [[0, 3, 6, 9, 12, 15], [3, 3, 3, 3, 3], [0, 0, 0, 0]])
  end

  test "difference tree second" do
    assert(difference_tree(Enum.at(read(@input), 1), []) ==  [[1, 3, 6, 10, 15, 21], [2, 3, 4, 5, 6], [1, 1, 1, 1], [0, 0, 0]])
  end

  test "predict" do
    assert(predict(difference_tree(List.first(read(@input)), [])) == 18)
  end

  test "predict second" do
    assert(predict(difference_tree(Enum.at(read(@input), 1), [])) == 28)
  end

  test "predict third" do
    assert(predict(difference_tree(Enum.at(read(@input), 2), [])) == 68)
  end

end
