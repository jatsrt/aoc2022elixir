defmodule Aoc2022elixir.Day04 do
  require Logger

  def run(contents) do
    overlaps =
      String.split(contents, "\n")
      |> Enum.map(fn pair ->
        String.split(pair, ",")
        |> Enum.map(fn area ->
          [s, e] = String.split(area, "-") |> Enum.map(&String.to_integer/1)
          MapSet.new(s..e)
        end)
      end)
      |> Enum.map(fn [x, y] ->
        {MapSet.size(MapSet.intersection(x, y)), min(MapSet.size(x), MapSet.size(y))}
      end)

    solution =
      Enum.reduce(overlaps, 0, fn {count, min}, acc -> if count >= min, do: acc + 1, else: acc end)

    Logger.info("solved", solution: solution, part: :one)

    solution =
      Enum.reduce(overlaps, 0, fn {count, _}, acc -> if count > 0, do: acc + 1, else: acc end)

    Logger.info("solved", solution: solution, part: :two)
  end
end
