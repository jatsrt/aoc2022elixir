defmodule Aoc2022elixir.Day04 do
  require Logger

  def run(contents) do
    areas =
      String.split(contents, "\n")
      |> Enum.map(fn pair ->
        String.split(pair, ",")
        |> Enum.map(fn area ->
          String.split(area, "-") |> Enum.map(&String.to_integer/1)
        end)
      end)

    solution = Enum.reduce(areas, 0, &contains/2)
    Logger.info("solved", solution: solution, part: :one)

    solution = Enum.reduce(areas, 0, &overlaps/2)
    Logger.info("solved", solution: solution, part: :two)
  end

  defp contains([[s1, e1], [s2, e2]], acc) when s2 <= s1 and e2 >= e1, do: acc + 1
  defp contains([[s1, e1], [s2, e2]], acc) when s1 <= s2 and e1 >= e2, do: acc + 1
  defp contains(_, acc), do: acc

  defp overlaps([[s1, e1], [s2, _]], acc) when s2 >= s1 and s2 <= e1, do: acc + 1
  defp overlaps([[s1, e1], [_, e2]], acc) when e2 >= s1 and e2 <= e1, do: acc + 1
  defp overlaps([[s1, _], [s2, e2]], acc) when s1 >= s2 and s1 <= e2, do: acc + 1
  defp overlaps([[_, e1], [s2, e2]], acc) when e1 >= s2 and e1 <= e2, do: acc + 1
  defp overlaps(_, acc), do: acc
end
