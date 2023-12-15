ExUnit.start()

{:ok, input} = File.read("input.txt")

defmodule RealTest do
  use ExUnit.Case, async: true
  import Escape

  @input input

  @matrix matrix(@input)

  @index index(@matrix)

  @start start(@index)


  test "possible east" do
    assert(possible(@matrix, {114, 19}, "L", [{114, 17}, {114, 18}, {114, 19}]) == [{115, 19}])
  end

  test "east? problem" do
    assert(east?(@matrix, {114, 19}) == true)
  end

  test "possible problem" do
    assert(possible(@matrix, {117, 23}, "J", [{114, 22}, {114, 23}, {114, 24}, {115, 24}, {116, 24}, {116, 23}, {117, 23}]) == [{117, 22}])
  end
end
