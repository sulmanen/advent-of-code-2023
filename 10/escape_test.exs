ExUnit.start()

defmodule EscapeTest do
  use ExUnit.Case, async: true
  import Escape

  @input """
  7-F7-
  .FJ|7
  SJLL7
  |F--J
  LJ.LJ
  """

  @matrix matrix(@input)

  @index index(@matrix)

  @start start(@index)

  @possible possible(@matrix, @start)

  test "matrix" do
    assert(@matrix == [["7", "-", "F", "7", "-"], [".", "F", "J", "|", "7"], ["S", "J", "L", "L", "7"], ["|", "F", "-", "-", "J"], ["L", "J", ".", "L", "J"]])
  end

  test "index" do
    assert(@index == [
              {[{"7", 0}, {"-", 1}, {"F", 2}, {"7", 3}, {"-", 4}], 0},
              {[{".", 0}, {"F", 1}, {"J", 2}, {"|", 3}, {"7", 4}], 1},
              {[{"S", 0}, {"J", 1}, {"L", 2}, {"L", 3}, {"7", 4}], 2},
              {[{"|", 0}, {"F", 1}, {"-", 2}, {"-", 3}, {"J", 4}], 3},
              {[{"L", 0}, {"J", 1}, {".", 2}, {"L", 3}, {"J", 4}], 4}
            ])
  end

  test "start" do
    assert(@start == {0, 2})
  end

  test "possible" do
    assert(@possible == [])
  end

  test "north" do
    assert(north(@index, @start) == "")
  end
end
