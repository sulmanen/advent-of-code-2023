defmodule Gears do

  def adjacent(star, aggregates) do
    aggregates
    |> Enum.filter(fn (aggregate) -> Enum.any?(Enum.map(elem(aggregate, 1), fn(number_coordinate) -> Parts.adjacent?([{elem(star, 1), elem(star, 2)}], elem(number_coordinate, 0), elem(number_coordinate, 1)) end)) end)
  end

  def gears(aggregates, stars) do
    Enum.map(stars, fn (star) -> adjacent(star, aggregates) end)
    |> Enum.filter(fn (adjacent) -> Enum.count(adjacent) == 2 end)
  end

  def gear_ratios(gears) do
    Enum.map(gears, fn gear -> gear_ratio(gear) end)
  end

  def first_gear(gear) do
    elem(Integer.parse(elem(List.first(gear), 0), 10), 0)
  end

  def last_gear(gear) do
    elem(Integer.parse(elem(List.last(gear), 0), 10), 0)
  end

  def gear_ratio(gear) do
    first_gear(gear) * last_gear(gear)
  end
end
