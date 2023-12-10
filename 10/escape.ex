import Enum

defmodule Escape do

  def matrix(input) do
    String.split(input, "\n")
    |> reduce([], fn (line, acc) -> concat(acc, [String.graphemes(line)]) end)
    |> filter(fn (line) -> !Enum.empty?(line) end)
  end

  def index(matrix) do
    matrix
    |> map(fn (line) -> with_index(line) end)
    |> with_index
  end

  def start(matrix_with_index) do
    reduce(matrix_with_index, {}, fn (line_with_index, acc) -> reduce(elem(line_with_index, 0), acc, fn(char_with_index, acc) -> if elem(char_with_index, 0) == "S", do: {elem(char_with_index, 1), elem(line_with_index, 1)}, else: acc end) end)
  end

  def west?(node) do
    (elem(node, 0) - 1) >= 0
  end

  def north?(node) do
    (elem(node, 1) - 1) >= 0
  end

  def south?(matrix, node) do
    count(matrix) > (elem(node, 1) + 1)
  end

  def east?(matrix, node) do
    count(at(matrix, 0)) > (elem(node, 0) + 1)
  end

  def north(matrix, node) do
    if north?(node) do
      { at(at(matrix, elem(node, 1) - 1), elem(node, 0)), {elem(node, 0), elem(node, 1) - 1}}
    else
      nil
    end
  end

  def south(matrix, node) do
    if south?(matrix, node) do
      { at(at(matrix, elem(node, 1) + 1), elem(node, 0)), {elem(node, 1), elem(node, 1) + 1}}
    else
      nil
    end
  end

  def east(matrix, node) do
    if east?(matrix, node) do
      { at(at(matrix, elem(node, 1)), elem(node, 0) + 1), {elem(node, 0) + 1, elem(node, 1) }}
    else
      nil
    end
  end

  def west(matrix, node, char) do
    if west?(node) do
      case { char, at(at(matrix, elem(node, 1)), elem(node, 0) - 1) } do
        {"S", "F"} -> {elem(node, 0) - 1, elem(node, 1) }
        {"S", "-"} -> {elem(node, 0) - 1, elem(node, 1) }
        {"S", "L"} -> {elem(node, 0) - 1, elem(node, 1) }
        {"7", "F" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"7", "S" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"7", "L" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"7", "-" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"J", "S" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"J", "F"} -> {elem(node, 0) - 1, elem(node, 1) }
        {"J", "L" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"J", "-" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"-", "L" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"-", "S" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"-", "F" } -> {elem(node, 0) - 1, elem(node, 1) }
        {"-", "-" } -> {elem(node, 0) - 1, elem(node, 1) }
        _ -> nil
      end
    else
      nil
    end
  end


# | is a vertical pipe connecting north and south.
# - is a horizontal pipe connecting east and west.
# L is a 90-degree bend connecting north and east.
# J is a 90-degree bend connecting north and west.
# 7 is a 90-degree bend connecting south and west.
# F is a 90-degree bend connecting south and east.
# . is ground; there is no pipe in this tile.
# S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
  def possible(matrix, node, char) do

  end

  def forward(matrix, node) do

  end

  def backward(matrix, node) do

  end
end
