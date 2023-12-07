defmodule Parts do
  @numbers ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  @non_symbol Enum.concat(["."], @numbers)

  def top?(symbols, x, y) do Enum.member?(symbols, {x, y - 1}) end

  def bottom?(symbols, x, y) do Enum.member?(symbols, {x, y + 1}) end

  def left?(symbols, x, y) do Enum.member?(symbols, {x - 1, y}) end

  def right?(symbols, x, y) do Enum.member?(symbols, {x + 1, y}) end

  def top_right?(symbols, x, y) do Enum.member?(symbols, {x + 1, y - 1}) end

  def top_left?(symbols, x, y) do Enum.member?(symbols, {x - 1, y - 1}) end

  def bottom_right?(symbols, x, y) do Enum.member?(symbols, {x + 1, y + 1}) end

  def bottom_left?(symbols, x, y) do Enum.member?(symbols, {x - 1, y + 1}) end

  def adjacent?(x, y, symbols) do
                  top?(x, y, symbols) or
                  bottom?(x, y, symbols) or
                  left?(x, y, symbols) or
                  right?(x, y, symbols) or
                  top_right?(x, y, symbols) or
                  top_left?(x, y, symbols) or
                  bottom_left?(x, y, symbols) or
                  bottom_right?(x, y, symbols) end

  def symbol_coordinates_from(schematic) do
    Enum.with_index(String.split(schematic, "\n"))
    |> Enum.map(fn(line) ->
      Enum.with_index(String.graphemes(elem(line, 0)))
      |> Enum.map(fn(c) -> if not Enum.member?(@non_symbol, elem(c, 0)), do: {elem(c, 1), elem(line, 1)}
      end)
      |> List.flatten
      |> Enum.filter(fn(e) -> not is_nil(e) end)
    end)
    |> List.flatten
  end

  def numbers_and_coordinates(schematic) do
    Enum.with_index(String.split(schematic, "\n"))
    |> Enum.map(fn(line) ->
      Enum.with_index(String.graphemes(elem(line, 0)))
      |> Enum.map(fn(c) -> if Enum.member?(@numbers, elem(c, 0)), do: {elem(c, 0), elem(c, 1), elem(line, 1)} end)
      |> List.flatten
      |> Enum.filter(fn(e) -> not is_nil(e) end)
    end)
    |> List.flatten
  end

  def aggregate(numbers) do
    Enum.reduce(numbers, [], fn (number_and_coordinate, acc) ->
      if acc != [] and (elem(number_and_coordinate, 1) - 1) == elem(List.last(elem(List.last(acc), 1)), 0),
   do: List.replace_at(acc, -1, {"#{elem(List.last(acc), 0)}#{elem(number_and_coordinate, 0)}", Enum.concat(elem(List.last(acc), 1), [{elem(number_and_coordinate, 1), elem(number_and_coordinate, 2)}])}), else: Enum.concat(acc, [{"#{elem(number_and_coordinate,0)}", [{elem(number_and_coordinate, 1), elem(number_and_coordinate, 2)}]}])  end)
  end
end
