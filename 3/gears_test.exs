ExUnit.start()

defmodule GearsTest do
  use ExUnit.Case, async: true
  import Gears

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

  @numbers_and_coordinates Parts.numbers_and_coordinates(@schematic)
  @stars Parts.coordinates_for_stars(@schematic)
  @aggregate Parts.aggregate(@numbers_and_coordinates)
  @gears gears(@aggregate, @stars)
  @gear adjacent(List.first(@stars), @aggregate)


  test "stars" do
    assert(@stars == [{"*", 3, 1}, {"*", 3, 4}, {"*", 5, 8}])
  end

  test "gears" do
    assert(@gears == [[{"467", [{0, 0}, {1, 0}, {2, 0}]}, {"35", [{2, 2}, {3, 2}]}], [{"755", [{6, 7}, {7, 7}, {8, 7}]}, {"598", [{5, 9}, {6, 9}, {7, 9}]}]])
  end

  test "adjacent" do
    assert(@gear == [{"467", [{0, 0}, {1, 0}, {2, 0}]}, {"35", [{2, 2}, {3, 2}]}])
  end
end
