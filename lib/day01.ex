defmodule Aoc2022elixir.Day01 do
  require Logger

  def run(contents) do
    caloric_results =
      contents
      |> String.split("\n\n")
      |> Enum.map(fn calories ->
        String.split(calories, "\n", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.sum()
      end)
      |> Enum.sort(:desc)

    [solution | _] = caloric_results
    Logger.info("solved", solution: solution, part: :one)

    solution = caloric_results |> Enum.take(3) |> Enum.sum()
    Logger.info("solved", solution: solution, part: :two)
  end
end
