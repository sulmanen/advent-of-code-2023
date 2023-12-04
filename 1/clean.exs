#  Advent of code 1 / 1
numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
numbersForWords = Enum.zip(words, numbers)
firstLast = fn (n) -> "#{List.first(n)}#{List.last(n)}" end
#test = ["two1nine","eightwothree", "abcone2threexyz", "xtwone3four", "4nineeightseven2", "zoneight234", "7pqrstsixteen"]
test = ["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f","treb7uchet"]
# Read file
#"input.txt"
#|> File.stream!
test
|> Enum.map(fn mangled -> String.replace(mangled, ~r/one|two|three|four|five|six|seven|eight|nine/, fn (match) -> Enum.find_value(numbersForWords, fn (numberForWord) -> if elem(numberForWord, 0) == match, do: elem(numberForWord, 1) end) end) end)
|> Enum.map(fn mangled -> Enum.filter(String.graphemes(mangled), fn(c) -> Enum.member?(numbers, c) end) end)
|> Enum.map(fn mangled -> firstLast.(mangled) end)
|> Enum.map(fn number -> Integer.parse(number, 10) end)
|> Enum.map(fn (n) -> elem(n, 0) end)
|> Enum.sum
|> IO.puts
#|> Enum.map(fn (s) -> IO.puts("#{s}") end)
