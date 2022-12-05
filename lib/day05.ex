defmodule Aoc2022elixir.Day05 do
  require Logger

  def run(contents) do
    [raw_stacks, raw_moves] =
      String.split(contents, "\n\n", trim: true) |> Enum.map(&String.split(&1, "\n"))

    stack_rows =
      Enum.map(raw_stacks, fn row ->
        String.codepoints(row)
        |> Enum.chunk_every(4)
        |> Enum.map(&Enum.join/1)
        |> Enum.map(&String.trim/1)
      end)
      |> List.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.filter(&1, fn i -> i != "" end))
      |> Stream.with_index(1)
      |> Enum.reduce(%{}, fn {v, k}, acc -> Map.put(acc, k, v) end)

    moves =
      Enum.map(raw_moves, &String.split(&1, " "))
      |> Enum.map(fn move ->
        %{
          c: Enum.at(move, 1) |> String.to_integer(),
          f: Enum.at(move, 3) |> String.to_integer(),
          t: Enum.at(move, 5) |> String.to_integer()
        }
      end)

    stacks = moves |> Enum.reduce(stack_rows, &ms9000/2)
    print_solution(stacks, :one)
    stacks = moves |> Enum.reduce(stack_rows, &ms9001/2)
    print_solution(stacks, :two)
  end

  defp print_solution(stacks, part) do
    solution =
      Enum.map(stacks, fn {_, [v | _]} -> v end)
      |> Enum.join("")
      |> String.replace(["[", "]"], "")

    Logger.info("solved", solution: solution, part: part)
  end

  defp ms9000(%{c: 0}, stacks), do: stacks
  defp ms9000(%{c: c, f: f, t: t} = m, stacks), do: ms9000(%{m | c: c - 1}, m9000(stacks, f, t))

  defp m9000(stacks, f, t) do
    [item | from_rest] = Map.get(stacks, f)

    Map.put(stacks, t, [item | Map.get(stacks, t)])
    |> Map.put(f, from_rest)
  end

  defp ms9001(%{c: c, f: f, t: t}, stacks) do
    {items, from_rest} = stacks |> Map.get(f) |> Enum.split(c)

    Map.put(stacks, t, Enum.concat(items, Map.get(stacks, t)))
    |> Map.put(f, from_rest)
  end
end
