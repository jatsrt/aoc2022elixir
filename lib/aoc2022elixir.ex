defmodule Aoc2022elixir do
  require Logger

  def run() do
    Logger.info("aoc-2022")
    run_aoc_day(1)
    run_aoc_day(2)
    run_aoc_day(3)
    run_aoc_day(4)
    run_aoc_day(5)
    run_aoc_day(6)
    run_aoc_day(7)
    run_aoc_day(8)
    run_aoc_day(9)
  end

  defp run_aoc_day(day) do
    Logger.metadata(day: day)

    input =
      "./inputs/day#{day |> Integer.to_string() |> String.pad_leading(2, "0")}.input"
      |> File.read()

    case input do
      {:ok, input} -> run_aoc_day(day, input)
      {:error, :enoent} -> Logger.error("file-missing")
      {:error, reason} -> Logger.error(reason |> inspect())
    end
  end

  defp run_aoc_day(1, input), do: Aoc2022elixir.Day01.run(input)
  defp run_aoc_day(2, input), do: Aoc2022elixir.Day02.run(input)
  defp run_aoc_day(3, input), do: Aoc2022elixir.Day03.run(input)
  defp run_aoc_day(4, input), do: Aoc2022elixir.Day04.run(input)
  defp run_aoc_day(5, input), do: Aoc2022elixir.Day05.run(input)
  defp run_aoc_day(6, input), do: Aoc2022elixir.Day06.run(input)
  defp run_aoc_day(7, input), do: Aoc2022elixir.Day07.run(input)
  defp run_aoc_day(8, input), do: Aoc2022elixir.Day08.run(input)
  defp run_aoc_day(_, _), do: Logger.info("no-day")
end
