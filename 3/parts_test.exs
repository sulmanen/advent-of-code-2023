ExUnit.start()


defmodule PartsTest do
  use ExUnit.Case, async: true
  import Parts
  @schematic """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """
  @symbols Parts.symbol_coordinates_from(@schematic)
  @numbers_and_coordinates Parts.numbers_and_coordinates(@schematic)
  @aggregate Parts.aggregate(@numbers_and_coordinates)
  @coordinates_for_stars Parts.coordinates_for_stars(@schematic)

  test "coordinates for stars" do
    assert(@coordinates_for_stars == [{"*", 3, 1}, {"*", 3, 4}, {"*", 5, 8}])
  end

  test "467 is adjacent" do
    assert(Parts.adjacent?(@symbols, 2, 0))
  end

  test "144 is not adjacent" do
    assert(not Parts.adjacent?(@symbols, 5, 0))
  end

  test "symbols_coordinates_from finds 6 symbols" do
    assert(Enum.count(@symbols) == 6)
  end

  test "first symbol is at {3, 1}" do
    assert(List.first(@symbols) == {3, 1})
  end

  test "last symbol is at {5, 8}" do
    assert(List.last(@symbols) == {5, 8})
  end

  test "bottom right 2, 0 contains symbol" do
    assert(Parts.bottom_right?(@symbols, 2, 0))
  end

  test "top right 4, 6 contains symbol" do
    assert(Parts.top_right?(@symbols, 4, 6))
  end

  test "top 3, 9 contains symbol" do
    assert(Parts.top?(@symbols, 3, 9))
  end

  test "bottom 6, 2 contains symbol" do
    assert(Parts.bottom?(@symbols, 6, 2))
  end

  test "bottom left 6,6 contains symbol" do
    assert(Parts.bottom_left?(@symbols, 6, 7))
  end

  test "numbers_and_coordinates fifth number is 6" do
    assert(@numbers_and_coordinates == [{"4", 0, 0}, {"6", 1, 0}, {"7", 2, 0}, {"1", 5, 0}, {"1", 6, 0}, {"4", 7, 0}, {"3", 2, 2}, {"5", 3, 2}, {"6", 6, 2}, {"3", 7, 2}, {"3", 8, 2}, {"6", 0, 4}, {"1", 1, 4}, {"7", 2, 4}, {"5", 7, 5}, {"8", 8, 5}, {"5", 2, 6}, {"9", 3, 6}, {"2", 4, 6}, {"7", 6, 7}, {"5", 7, 7}, {"5", 8, 7}, {"6", 1, 9}, {"6", 2, 9}, {"4", 3, 9}, {"5", 5, 9}, {"9", 6, 9}, {"8", 7, 9}])
  end

  test "aggregate" do
    assert(elem(List.first(@aggregate), 0) == "467")
  end

  test "aggregate coordinate" do
    assert(elem(List.first(@aggregate), 1) == [{0,0}, {1,0}, {2,0}])
  end

  test "sum" do
    assert(Parts.sum_of_adjacent(@aggregate, @symbols) == 4361)
  end
end
