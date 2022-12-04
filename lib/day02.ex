defmodule Aoc2022elixir.Day02 do
  require Logger

  def run(contents) do
    strategy = contents |> String.split("\n")

    result = strategy |> Enum.reduce(0, &solution(&1, &2, 0))
    Logger.info("solved", solution: result, part: :one)

    result = strategy |> Enum.reduce(0, &solution(&1, &2, 1))
    Logger.info("solved", solution: result, part: :two)
  end

  @values %{
    "A X" => {4, 3},
    "A Y" => {8, 4},
    "A Z" => {3, 8},
    "B X" => {1, 1},
    "B Y" => {5, 5},
    "B Z" => {9, 9},
    "C X" => {7, 2},
    "C Y" => {2, 6},
    "C Z" => {6, 7}
  }

  defp solution(key, acc, i), do: elem(Map.get(@values, key), i) + acc
end
