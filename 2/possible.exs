red = 12
blue = 14
green = 13

possible_color? = fn (lifts, color, bag_count) ->
  lifts
  |> List.flatten
  |> Enum.filter(fn (lift) -> String.contains?(lift, color) end)
  |> Enum.map(fn (pick) -> Integer.parse(pick, 10) end)
  |> Enum.map(fn (count) -> elem(count, 0) end)
  |> Enum.map(fn (count) -> count <= bag_count end)
  |> Enum.all?
end

possible? = fn (lifts) -> possible_color?.(lifts, "blue", blue) and possible_color?.(lifts, "red", red) and possible_color?.(lifts, "green", green) end

"input.txt"
|> File.stream!
|> Enum.map(fn (game) -> {Regex.named_captures(~r/Game (?<game>\d+):/, game), Regex.scan(~r/\d+ (?:red|green|blue)/, game)} end)
|> Enum.filter(fn (game) -> possible?.(elem(game, 1)) end)
|> Enum.map(fn (game) -> elem(game, 0)["game"] end)
|> Enum.map(fn (game_number) -> elem(Integer.parse(game_number, 10), 0) end)
|> Enum.sum
|> IO.puts
