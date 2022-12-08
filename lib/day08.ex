defmodule Aoc2022elixir.Day08 do
  require Logger

  def run(contents) do
    forest = contents |> String.split("\n", trim: true) |> Enum.map(&String.codepoints/1)
    rows = forest |> Enum.with_index()
    columns = forest |> Enum.zip() |> Enum.map(&Tuple.to_list/1)

    solution = Enum.reduce(rows, %{}, &look_row(&1, &2, columns)) |> Enum.count()
    Logger.info("solved", solution: solution, part: :one)

    solution = Enum.reduce(rows, 0, &score_row(&1, &2, columns))
    Logger.info("solved", solution: solution, part: :two)
  end

  defp look_row({row, y}, acc, columns),
    do: Enum.reduce(row |> Enum.with_index(), acc, &look(&1, &2, row, y, columns))

  defp score_row({row, y}, acc, columns),
    do: Enum.reduce(row |> Enum.with_index(), acc, &score(&1, &2, row, y, columns))

  defp look({v, x}, acc, row, y, columns) do
    col = columns |> Enum.at(x)
    l = row |> Enum.take(x) |> Enum.max(fn -> -1 end)
    r = row |> Enum.slice((x + 1)..length(row)) |> Enum.max(fn -> -1 end)
    u = col |> Enum.take(y) |> Enum.max(fn -> -1 end)
    d = col |> Enum.slice((y + 1)..length(row)) |> Enum.max(fn -> -1 end)

    cond do
      v > l || v > r || v > u || v > d -> Map.put(acc, %{x: x, y: y}, true)
      true -> acc
    end
  end

  defp score({v, x}, acc, row, y, columns) do
    col = columns |> Enum.at(x)
    l = Enum.take(row, x) |> Enum.reverse() |> Enum.reduce_while(0, &vis(&1, &2, v))
    r = Enum.slice(row, (x + 1)..length(row)) |> Enum.reduce_while(0, &vis(&1, &2, v))
    u = Enum.take(col, y) |> Enum.reverse() |> Enum.reduce_while(0, &vis(&1, &2, v))
    d = Enum.slice(col, (y + 1)..length(row)) |> Enum.reduce_while(0, &vis(&1, &2, v))
    max(acc, l * r * u * d)
  end

  defp vis(x, acc, v) do
    cond do
      v > x -> {:cont, acc + 1}
      v == x -> {:halt, acc + 1}
      true -> {:halt, acc}
    end
  end
end
