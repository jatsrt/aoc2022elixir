defmodule Aoc2022elixir.Day04 do
  require Logger

  def run(contents) do
    overlaps =
      Enum.map(String.split(contents, "\n"), fn pair ->
        Enum.map(String.split(pair, ","), fn area ->
          [s, e] = String.split(area, "-") |> Enum.map(&String.to_integer/1)
          MapSet.new(s..e)
        end)
      end)
      |> Enum.map(fn [x, y] ->
        {MapSet.size(MapSet.intersection(x, y)), min(MapSet.size(x), MapSet.size(y))}
      end)

    solution = Enum.count(overlaps, fn {count, min} -> count >= min end)
    Logger.info("solved", solution: solution, part: :one)

    solution = Enum.count(overlaps, fn {count, _} -> count > 0 end)
    Logger.info("solved", solution: solution, part: :two)
  end
end
