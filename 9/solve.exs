import Sensor

{:ok, input} = File.read("input.txt")

read(input)
|> Enum.map(fn (series) -> predict(difference_tree(series, [])) end)
|> Enum.sum
|> IO.puts
