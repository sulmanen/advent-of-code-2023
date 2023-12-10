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

  def north(matrix_with_index, node) do
    matrix_with_index
    |> filter(fn(line) -> elem(line, 1) == elem(node, 1) - 1 end)
    |> map(fn (line) -> at(elem(line, 0), 0) end)
    |> filter(fn (char) -> elem(char, 1) == elem(node, 0) end)
  end

  def possible(matrix, node) do

  end

  def forward(matrix, node) do

  end

  def backward(matrix, node) do

  end
end
