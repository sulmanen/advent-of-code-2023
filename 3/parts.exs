non_symbol = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]

symbols = "input.txt"
|> File.stream!
|> Enum.map(fn(line, y) -> String.graphemes
  |> Enum.map(fn(c, x) -> if not Enum.member?(non_symbol, c), do: [x, y] end) end)
|> IO.puts

top? = fn (x, y) -> Enum.member?(symbols, [x, y - 1]) end
bottom? = fn (x, y) -> Enum.member?(symbols, [x, y + 1]) end
left? = fn (x, y) -> Enum.member?(symbols, [x - 1, y]) end
right? = fn (x, y) -> Enum.member?(symbols, [x + 1, y]) end
top_right? = fn (x, y) -> Enum.member?(symbols, [x + 1, y - 1]) end
top_left? = fn (x, y) -> Enum.member?(symbols, [x - 1, y - 1]) end
bottom_right? = fn (x, y) -> Enum.member?(symbols, [x + 1, y + 1]) end
bottom_left? = fn (x, y) -> Enum.member?(symbols, [x - 1, y + 1]) end

adjacent? = fn(x, y) ->
  top?.(x, y) or
  bottom?.(x, y) or
  left?.(x, y) or
  right?.(x, y) or
  top_right?.(x, y) or
  top_left?.(x, y) or
  bottom_left?.(x, y) or
  bottom_right?.(x, y) end
