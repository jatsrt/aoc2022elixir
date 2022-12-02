defmodule Aoc2022elixir.Day01 do
  require Logger

  def run(contents) do
    caloric_results =
      contents
      |> String.split("\n\n")
      |> Enum.map(fn
        calories ->
          String.split(calories, "\n", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.sum()
      end)
      |> Enum.sort(:desc)

    Logger.info("solved", solution: caloric_results |> Enum.at(0), part: :one)
    Logger.info("solved", solution: caloric_results |> Enum.take(3) |> Enum.sum(), part: :two)
  end
end
