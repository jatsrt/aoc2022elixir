defmodule Aoc2022elixir.Day06 do
  require Logger

  def run(contents) do
    sequence = contents |> String.split("\n", trim: true) |> Enum.at(0) |> String.codepoints()
    {seq, index} = sequence |> find_code(4)
    Logger.info("solved: #{seq |> Enum.join()}", solution: index + 5, part: :one)

    {seq, index} = sequence |> find_code(14)
    Logger.info("solved: #{seq |> Enum.join()}", solution: index + 15, part: :two)
  end

  defp find_code(seq, length) do
    Stream.chunk_every(seq, length, 1, :discard)
    |> Stream.with_index()
    |> Stream.take_while(fn {chunk, _} -> length(chunk |> Enum.uniq()) != length end)
    |> Enum.at(-1)
  end
end
