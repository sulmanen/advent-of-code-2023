defmodule Sensor do
  def read(input) do
    String.split(input, "\n")
    |> Enum.map(fn (line) -> String.split(line, " ") end)
    |> Enum.map(fn (line) -> Enum.map(line, fn(number) -> Integer.parse(number, 10) end) end)
    |> Enum.reject(fn (line) -> Enum.member?(line, :error) end)
    |> Enum.map(fn (line) -> Enum.map(line, fn(number) -> elem(number, 0) end) end)
  end

  def difference(series) do
    Enum.reduce(series, [List.first(series)], fn(value, acc) -> Enum.concat(List.delete_at(acc, -1), [ value - List.last(acc), value]) end)
    |> List.delete_at(0)
    |> List.delete_at(-1)
  end

  def zeros?(diff) do
    Enum.all?(diff, fn (val) -> val == 0 end)
  end

  def difference_tree(series, acc) do
    if zeros?(series), do: Enum.concat(acc, [series]), else: difference_tree(difference(series), Enum.concat(acc, [series]))
  end

  def predict(tree) do
    Enum.reduce(tree, 0, fn(tree_part, acc) -> List.last(tree_part) + acc end)
  end
end
