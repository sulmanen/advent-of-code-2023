import Enum
defmodule Area do
  def has_y?(pipes, y) do
    pipes
    |> filter(fn(pipe_point) -> elem(pipe_point, 1) == y end)
    |> any?
  end

  def has_x?(pipes, x) do
    pipes
    |> filter(fn(pipe_point) -> elem(pipe_point, 0) == x end)
    |> any?
  end

  def min_x(pipes, y) do
    pipes
    |> filter(fn(pipe_point) -> elem(pipe_point, 1) == y end)
    |> min
  end

  def max_x(pipes, y) do
    pipes
    |> filter(fn(pipe_point) -> elem(pipe_point, 1) == y end)
    |> max
  end

  def max_y(pipes, x) do
    pipes
    |> filter(fn(pipe_point) -> elem(pipe_point, 0) == x end)
    |> max
  end

  def min_y(pipes, x) do
    pipes
    |> filter(fn(pipe_point) -> elem(pipe_point, 0) == x end)
    |> min
  end

  def inside?(pipes, point) do
    point_x = elem(point, 0)
    point_y = elem(point, 1)
    has_y?(pipes, point_y) and (point_x > min_x(pipes, point_y)) and (point_x < max_x(pipes, point_y)) and has_x?(pipes, point_x) and (point_y > min_y(pipes, point_x)) and (point_y < max_y(pipes, point_x))
  end
end
