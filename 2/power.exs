max_color? = fn (lifts, color) ->
  lifts
  |> List.flatten
  |> Enum.filter(fn (lift) -> String.contains?(lift, color) end)
  |> Enum.map(fn (pick) -> Integer.parse(pick, 10) end)
  |> Enum.map(fn (count) -> elem(count, 0) end)
  |> Enum.max
end

max? = fn (lifts) -> [max_color?.(lifts, "blue"),  max_color?.(lifts, "red"), max_color?.(lifts, "green")] end

"input.txt"
|> File.stream!
#["Game 9: 2 green, 20 blue, 4 red; 3 green, 7 red, 2 blue; 3 green, 17 blue; 20 blue, 7 red, 2 green; 4 green, 6 red, 1 blue; 7 red, 5 green, 19 blue"]
|> Enum.map(fn (game) -> {Regex.named_captures(~r/Game (?<game>\d+):/, game), Regex.scan(~r/\d+ (?:red|green|blue)/, game)} end)
|> Enum.map(fn (game) -> max?.(elem(game, 1)) end)
|> Enum.map(fn (game_max) -> Enum.reduce(game_max, 1, fn(max, acc) -> max * acc end) end)
|> Enum.sum
|> IO.puts
#|> Enum.map(fn (game_number) -> IO.puts(game_number) end)
#|> IO.puts
