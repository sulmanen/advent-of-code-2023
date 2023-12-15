import Enum

# | is a vertical pipe connecting north and south.
# - is a horizontal pipe connecting east and west.
# L is a 90-degree bend connecting north and east.
# J is a 90-degree bend connecting north and west.
# 7 is a 90-degree bend connecting south and west.
# F is a 90-degree bend connecting south and east.
# . is ground; there is no pipe in this tile.
# S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
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

  @north_possible_pipes [{"S", "F"}, {"S", "7"}, {"S", "|"},
                         {"J", "S"}, {"J", "F"}, {"J", "|"}, {"J", "7"},
                         {"L", "S"}, {"L", "F"}, {"L", "7"}, {"L", "|"},
                         {"|", "S"}, {"|", "F"}, {"|", "7"}, {"|", "|"}]

  def north(matrix, node, char) do
    if north?(node) and member?(@north_possible_pipes, {char, at(at(matrix, elem(node, 1) - 1), elem(node, 0))}) do
      {elem(node, 0), elem(node, 1) - 1}
    else
      nil
    end
  end

  @south_possible_pipes [{"S", "J"}, {"S", "L"}, {"S", "|"},
                         {"F", "S"}, {"F", "J"}, {"F", "L"}, {"F", "|"},
                         {"7", "S"}, {"7", "J"}, {"7", "L"}, {"7", "|"},
                         {"|", "S"}, {"|", "J"}, {"|", "L"}, {"|", "|"}]

  def south(matrix, node, char) do
    if south?(matrix, node) and member?(@south_possible_pipes, { char, at(at(matrix, elem(node, 1) + 1), elem(node, 0))}) do
      {elem(node, 0), elem(node, 1) + 1}
    else
      nil
    end
  end

  @east_possible_pipes [{"S", "7"}, {"S", "J"}, {"S", "-"},
                        { "F", "7" }, {"F", "J"}, { "F", "-"}, {"F", "S"},
                        { "L", "7" }, {"L", "J"}, { "L", "-"}, {"L", "S"},
                        { "-", "S" }, { "-", "7" }, { "-", "J"}, {"-", "-"}]

  def east(matrix, node, char) do
    if east?(matrix, node) and member?(@east_possible_pipes, { char, at(at(matrix, elem(node, 1)), elem(node, 0) + 1)}) do
      {elem(node, 0) + 1, elem(node, 1)}
    else
      nil
    end
  end

  @west_possible_pipes [{"S", "F"},{"S", "-"},{"S", "L"},
                        {"7", "F" }, {"7", "S" }, {"7", "L" }, {"7", "-" },
                        {"J", "S" }, {"J", "F"}, {"J", "L" }, {"J", "-" },
                        {"-", "L" }, {"-", "S" }, {"-", "F" }, {"-", "-" }]

  def west(matrix, node, char) do
    if west?(node) and member?(@west_possible_pipes, { char, at(at(matrix, elem(node, 1)), elem(node, 0) - 1) }) do
      {elem(node, 0) - 1, elem(node, 1) }
    else
      nil
    end
  end

  def possible(matrix, node, char, walked) do
    [north(matrix, node, char), east(matrix, node, char), south(matrix, node, char), west(matrix, node, char)]
    |> filter(fn(n) -> n != nil end)
    |> reject(fn(n) -> member?(walked, n) end)
  end

  def walk(node, walked) do
    concat(walked, [node])
  end

  def stop?(current_forward_node, current_backward_node) do
    current_forward_node == current_backward_node
  end

  def char_at(matrix, node) do
    at(at(matrix, elem(node, 1)), elem(node, 0))
  end

  def escape(matrix, current_forward_node, current_backward_node, forward_walked, backward_walked) do
    if stop?(current_forward_node, current_backward_node) do
      [forward_walked, backward_walked]
    else
      escape(
        matrix,
        at(possible(matrix, current_forward_node, char_at(matrix, current_forward_node), forward_walked), 0),
        at(possible(matrix, current_backward_node, char_at(matrix, current_backward_node), backward_walked), 0),
        concat(forward_walked, possible(matrix, current_forward_node, char_at(matrix, current_forward_node), forward_walked)),
        concat(backward_walked, possible(matrix, current_backward_node, char_at(matrix, current_backward_node), backward_walked)))
    end
  end
end
