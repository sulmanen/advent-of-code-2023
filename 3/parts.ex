defmodule Parts do
  @numbers ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  @non_symbol Enum.concat(["."], @numbers)
  @star "*"

  def top?(symbols, x, y) do Enum.member?(symbols, {x, y - 1}) end

  def bottom?(symbols, x, y) do Enum.member?(symbols, {x, y + 1}) end

  def left?(symbols, x, y) do Enum.member?(symbols, {x - 1, y}) end

  def right?(symbols, x, y) do Enum.member?(symbols, {x + 1, y}) end

  def top_right?(symbols, x, y) do Enum.member?(symbols, {x + 1, y - 1}) end

  def top_left?(symbols, x, y) do Enum.member?(symbols, {x - 1, y - 1}) end

  def bottom_right?(symbols, x, y) do Enum.member?(symbols, {x + 1, y + 1}) end

  def bottom_left?(symbols, x, y) do Enum.member?(symbols, {x - 1, y + 1}) end

  def adjacent?(symbols, x, y) do
                  top?(symbols, x, y) or
                  bottom?(symbols, x, y) or
                  left?(symbols, x, y) or
                  right?(symbols, x, y) or
                  top_right?(symbols, x, y) or
                  top_left?(symbols, x, y) or
                  bottom_left?(symbols, x, y) or
                  bottom_right?(symbols, x, y) end

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

  def coordinates_for(schematic, chars) do
    Enum.with_index(String.split(schematic, "\n"))
    |> Enum.map(fn(line) ->
      Enum.with_index(String.graphemes(elem(line, 0)))
      |> Enum.map(fn(c) -> if Enum.member?(chars, elem(c, 0)), do: {elem(c, 0), elem(c, 1), elem(line, 1)} end)
      |> List.flatten
      |> Enum.filter(fn(e) -> not is_nil(e) end)
    end)
    |> List.flatten
  end

  def numbers_and_coordinates(schematic) do
    coordinates_for(schematic, @numbers)
  end

  def coordinates_for_stars(schematic) do
    coordinates_for(schematic, [@star])
  end

  def aggregate(numbers) do
    Enum.reduce(numbers, [], fn (number_and_coordinate, acc) ->
      if acc != [] and (elem(number_and_coordinate, 1) - 1) == elem(List.last(elem(List.last(acc), 1)), 0),
   do: List.replace_at(acc, -1, {"#{elem(List.last(acc), 0)}#{elem(number_and_coordinate, 0)}", Enum.concat(elem(List.last(acc), 1), [{elem(number_and_coordinate, 1), elem(number_and_coordinate, 2)}])}), else: Enum.concat(acc, [{"#{elem(number_and_coordinate,0)}", [{elem(number_and_coordinate, 1), elem(number_and_coordinate, 2)}]}])  end)
  end

  def sum_of_adjacent(aggregates, symbols) do
    Enum.reduce(aggregates, 0, fn (aggregate, acc) -> acc + if Enum.map(elem(aggregate, 1), fn(number_coordinate) ->  adjacent?(symbols, elem(number_coordinate, 0), elem(number_coordinate, 1)) end) |> Enum.any?, do: elem(Integer.parse(elem(aggregate, 0), 10), 0), else: 0  end)
  end
end
