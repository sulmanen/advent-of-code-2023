import Sensor

{:ok, input} = File.read("input.txt")

IO.puts "Part 1"
read(input)
|> Enum.map(fn (series) -> predict(difference_tree(series, [])) end)
|> Enum.sum
|> IO.puts

IO.puts "Part 2"
read(input)
|> Enum.map(fn (series) -> predict_back(difference_tree(series, [])) end)
|> Enum.sum
|> IO.puts
