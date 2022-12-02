defmodule Aoc2022elixir.Day02 do
  require Logger

  def run(contents) do
    strategy = contents |> String.split("\n")

    result = strategy |> Enum.reduce(0, &solution(&1, &2, true))
    Logger.info("solved", solution: result, part: :one)

    result = strategy |> Enum.reduce(0, &solution(&1, &2, false))
    Logger.info("solved", solution: result, part: :two)
  end

  defp solution("A X", acc, tgl), do: if(tgl, do: 4, else: 3) + acc
  defp solution("A Y", acc, tgl), do: if(tgl, do: 8, else: 4) + acc
  defp solution("A Z", acc, tgl), do: if(tgl, do: 3, else: 8) + acc
  defp solution("B X", acc, tgl), do: if(tgl, do: 1, else: 1) + acc
  defp solution("B Y", acc, tgl), do: if(tgl, do: 5, else: 5) + acc
  defp solution("B Z", acc, tgl), do: if(tgl, do: 9, else: 9) + acc
  defp solution("C X", acc, tgl), do: if(tgl, do: 7, else: 2) + acc
  defp solution("C Y", acc, tgl), do: if(tgl, do: 2, else: 6) + acc
  defp solution("C Z", acc, tgl), do: if(tgl, do: 6, else: 7) + acc
end
