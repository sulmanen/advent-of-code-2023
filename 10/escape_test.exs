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

  test "north" do
    assert(north(@matrix, @start, "S") == nil)
  end

  test "south" do
    assert(south(@matrix, @start, "S") == {0, 3})
  end

  test "east" do
    assert(east(@matrix, @start, "S") == {1, 2})
  end

  test "west" do
    assert(west(@matrix, @start, "S") == nil)
  end

  test "possible" do
    assert(possible(@matrix, @start, "S", []) == [{1, 2}, {0, 3}])
  end

  test "possible prev" do
    assert(possible(@matrix, {0, 3}, "|", [{0,2}]) == [{0, 4}])
  end

  test "possible prev prev" do
    assert(possible(@matrix, {0, 4}, "L", [{0,2}, {0,3}]) == [{1, 4}])
  end

  test "possible prev prev prev" do
    assert(possible(@matrix, {1, 4}, char_at(@matrix, {1, 4}), [{0,2}, {0,3}, {0,4}]) == [{1, 3}])
  end

  test "possible prev prev prev prev" do
    assert(possible(@matrix, {1, 3}, char_at(@matrix, {1, 3}), [{0,2}, {0,3}, {0,4}, {1, 4}]) == [{2, 3}])
  end

  test "possible next" do
    assert(possible(@matrix, {1, 2}, "J", [{0, 2}]) == [{1, 1}])
  end

  test "possible next next" do
    assert(possible(@matrix, {1, 1}, "F", [{0, 2}, {1, 2}]) == [{2, 1}])
  end

  test "possible next next next" do
    assert(possible(@matrix, {2, 1}, "J", [{0, 2}, {1, 2}, {1, 1}]) == [{2, 0}])
  end

  test "escape" do
    assert(escape(@matrix, {1, 2}, {0, 3}, [{0,2}, {1,2}], [{0,2}, {0, 3}]) == [[{0, 2}, {1, 2}, {1, 1}, {2, 1}, {2, 0}, {3, 0}, {3, 1}, {3, 2}, {4, 2}], [{0, 2}, {0, 3}, {0, 4}, {1, 4}, {1, 3}, {2, 3}, {3, 3}, {4, 3}]])
  end
end
