defmodule Aoc2022elixir.Day05 do
  require Logger

  def run(contents) do
    [raw_stacks, raw_moves] = contents |> String.split("\n\n")
    stacks = generate_stacks(raw_stacks |> String.split("\n"))
    moves = generate_moves(raw_moves |> String.split("\n"))

    solution = move9000(moves, stacks)
    Logger.info("solved", solution: solution, part: :one)

    solution = move9001(moves, stacks)
    Logger.info("solved", solution: solution, part: :two)
  end

  defp move9000(moves, stacks),
    do:
      Enum.reduce(moves, stacks, &mover9000/2)
      |> Enum.map(fn {_, [v | _]} -> v end)
      |> Enum.join("")

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

  defp move9001(moves, stacks),
    do:
      Enum.reduce(moves, stacks, &mover9001/2)
      |> Enum.map(fn {_, [v | _]} -> v end)
      |> Enum.join("")

  defp mover9001(%{count: count, from: from, to: to}, stacks) do
    {crates, remainder_crates} = stacks |> Map.get(from) |> Enum.split(count)

    stacks
    |> Map.put(to, Enum.concat(crates, Map.get(stacks, to)))
    |> Map.put(from, remainder_crates)
  end

  defp generate_stacks(raw_stacks),
    do:
      Enum.map(raw_stacks, fn row ->
        row |> String.codepoints() |> Enum.chunk_every(4) |> Enum.map(&Enum.at(&1, 1))
      end)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.filter(&1, fn i -> i != " " end))
      |> Stream.with_index(1)
      |> Enum.reduce(%{}, fn {v, k}, acc -> Map.put(acc, k, v) end)

  defp generate_moves(raw_moves),
    do:
      Enum.map(raw_moves, &String.split(&1, " "))
      |> Enum.map(fn move ->
        %{
          count: Enum.at(move, 1) |> String.to_integer(),
          from: Enum.at(move, 3) |> String.to_integer(),
          to: Enum.at(move, 5) |> String.to_integer()
        }
      end)
end
