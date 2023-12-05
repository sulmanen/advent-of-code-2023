schematic = """
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

defmodule PartsTest do
  use ExUnit.Case
  import Parts

  setup_all do
    {:ok, recipient: :world}
  end

  test "top" do
    assert top?(9, 4) == true
  end
end
