defmodule Aoc2022elixir.Day05 do
  require Logger

  def run(contents) do
    [raw_stacks, raw_moves] =
      contents |> String.split("\n\n", trim: true) |> Enum.map(&String.split(&1, "\n"))

    stacks =
      raw_stacks
      |> Enum.map(fn row ->
        row
        |> String.codepoints()
        |> Enum.chunk_every(4)
        |> Enum.map(&Enum.join/1)
        |> Enum.map(&String.trim/1)
        |> Enum.map(&String.replace(&1, ["[", "]"], ""))
      end)
      |> List.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.filter(&1, fn i -> i != "" end))
      |> Stream.with_index(1)
      |> Enum.reduce(%{}, fn {v, k}, acc -> Map.put(acc, k, v) end)

    moves =
      raw_moves
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn move ->
        %{
          c: Enum.at(move, 1) |> String.to_integer(),
          f: Enum.at(move, 3) |> String.to_integer(),
          t: Enum.at(move, 5) |> String.to_integer()
        }
      end)

    solution =
      moves
      |> Enum.reduce(stacks, &ms9000/2)
      |> Enum.map(fn {_, [v | _]} -> v end)
      |> Enum.join("")

    Logger.info("solved", solution: solution, part: :one)

    solution =
      moves
      |> Enum.reduce(stacks, &ms9001/2)
      |> Enum.map(fn {_, [v | _]} -> v end)
      |> Enum.join("")

    Logger.info("solved", solution: solution, part: :two)
  end

  defp ms9000(%{c: 0}, stacks), do: stacks
  defp ms9000(%{c: c, f: f, t: t} = m, stacks), do: ms9000(%{m | c: c - 1}, m9000(stacks, f, t))

  defp m9000(stacks, f, t) do
    [item | from_rest] = Map.get(stacks, f)

    stacks
    |> Map.put(t, [item | Map.get(stacks, t)])
    |> Map.put(f, from_rest)
  end

  defp ms9001(%{c: c, f: f, t: t}, stacks) do
    {items, from_rest} = stacks |> Map.get(f) |> Enum.split(c)

    stacks
    |> Map.put(t, Enum.concat(items, Map.get(stacks, t)))
    |> Map.put(f, from_rest)
  end
end
