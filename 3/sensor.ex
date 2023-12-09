defmodule Sensor do
  def read(input) do
    String.split(input, "\n")
    |> Enum.map(fn (line) -> elem(Integer.parse(String.split(line, " "), 10), 0) end)
  end

  def difference(values) do
    []
  end
end
