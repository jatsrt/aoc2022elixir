defmodule Aoc2022elixir.Day05 do
  require Logger

  def run(contents) do
    [raw_stacks, raw_moves] =
      contents |> String.split("\n\n", trim: true) |> Enum.map(&String.split(&1, "\n"))

    stacks =
      raw_stacks
      |> Enum.map(fn row ->
        row |> String.codepoints() |> Enum.chunk_every(4) |> Enum.map(&Enum.at(&1, 1))
      end)
      |> List.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.filter(&1, fn i -> i != " " end))
      |> Stream.with_index(1)
      |> Enum.reduce(%{}, fn {v, k}, acc -> Map.put(acc, k, v) end)

    moves =
      raw_moves
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn move ->
        %{
          count: Enum.at(move, 1) |> String.to_integer(),
          from: Enum.at(move, 3) |> String.to_integer(),
          to: Enum.at(move, 5) |> String.to_integer()
        }
      end)

    solution =
      moves
      |> Enum.reduce(stacks, &mover9000/2)
      |> Enum.map(fn {_, [v | _]} -> v end)
      |> Enum.join("")

    Logger.info("solved", solution: solution, part: :one)

    solution =
      moves
      |> Enum.reduce(stacks, &mover9001/2)
      |> Enum.map(fn {_, [v | _]} -> v end)
      |> Enum.join("")

    Logger.info("solved", solution: solution, part: :two)
  end

  defp mover9000(%{count: 0}, stacks), do: stacks

  defp mover9000(%{count: count, from: from, to: to} = move, stacks) do
    [crate | remainder_crates] = Map.get(stacks, from)

    mover9000(
      %{move | count: count - 1},
      stacks
      |> Map.put(to, [crate | Map.get(stacks, to)])
      |> Map.put(from, remainder_crates)
    )
  end

  defp mover9001(%{count: count, from: from, to: to}, stacks) do
    {crates, remainder_crates} = stacks |> Map.get(from) |> Enum.split(count)

    stacks
    |> Map.put(to, Enum.concat(crates, Map.get(stacks, to)))
    |> Map.put(from, remainder_crates)
  end
end
