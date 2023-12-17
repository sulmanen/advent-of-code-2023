import Escape
import Area
import Enum

{:ok, input} = File.read("input.txt")

matrix = matrix(input)
matrix_index = index(matrix)
start_node = start(matrix_index)

start_possible = possible(matrix, start_node, "S", [start_node])
back = at(start_possible, 1)
forward = at(start_possible, 0)

pipes = escape(matrix, forward, back, [start_node, forward], [start_node, back])

IO.puts("Part 1:")
pipes
|> map(fn(walked) -> count(walked) end)
|> max
|> IO.puts

all_pipes = reduce(pipes, [], fn x, acc -> concat(acc, x) end)

IO.puts("Part 2:")
matrix_index
|> reduce(0, fn(line, acc) -> reduce(elem(line, 0), acc, fn(point, acc) -> if inside?(all_pipes, {elem(point, 1), elem(line, 1)}), do: acc + 1, else: acc end) end)
|> IO.puts
