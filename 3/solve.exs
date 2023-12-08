{:ok, input} = File.read("input.txt")

input
|> Parts.numbers_and_coordinates
|> Parts.aggregate
|> Parts.sum_of_adjacent(Parts.symbol_coordinates_from(input))
|> IO.puts
