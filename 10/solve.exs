import Escape
import Enum

{:ok, input} = File.read("input.txt")

matrix = matrix(input)

start_node = start(index(matrix))

start_possible = possible(matrix, start_node, "S", [start_node])
back = at(start_possible, 1)
forward = at(start_possible, 0)

escape(matrix, forward, back, [start_node, forward], [start_node, back])
|> map(fn(walked) -> count(walked) end)
|> max
|> IO.puts
