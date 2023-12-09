{:ok, input} = File.read("input.txt")

aggregates = input
|> Parts.numbers_and_coordinates
|> Parts.aggregate

aggregates
|> Parts.sum_of_adjacent(Parts.symbol_coordinates_from(input))
|> IO.puts

IO.puts(Enum.sum(Gears.gear_ratios(Gears.gears(aggregates, Parts.coordinates_for_stars(input)))))
