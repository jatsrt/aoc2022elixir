defmodule Aoc2022elixir.Day03 do
  require Logger

  def run(contents) do
    sacks = contents |> String.split("\n")

    priority_sum =
      Enum.map(sacks, fn sack ->
        String.codepoints(sack)
        |> Enum.split(div(String.length(sack), 2))
        |> Tuple.to_list()
        |> Enum.map(&MapSet.new/1)
        |> Enum.reduce(&MapSet.intersection/2)
        |> Enum.join("")
        |> alpha
      end)
      |> Enum.sum()

    Logger.info("solved", solution: priority_sum, part: :one)

    priority_sum =
      Enum.map(sacks, &String.codepoints/1)
      |> Enum.map(&MapSet.new/1)
      |> Enum.chunk_every(3)
      |> Enum.map(fn sackset ->
        Enum.reduce(sackset, &MapSet.intersection/2) |> Enum.join("") |> alpha
      end)
      |> Enum.sum()

    Logger.info("solved", solution: priority_sum, part: :two)
  end

  def alpha(<<c::8>>) when c in ?a..?z, do: c - 96
  def alpha(<<c::8>>) when c in ?A..?Z, do: c - 38
end
