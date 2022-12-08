defmodule Aoc2022elixir.Day06 do
  require Logger

  def run(contents) do
    sequence = contents |> String.codepoints()

    {seq, index} = find_code(sequence, 4)
    Logger.info("solved #{seq |> Enum.join()}", solution: index + 4, part: :one)

    {seq, index} = find_code(sequence, 14)
    Logger.info("solved #{seq |> Enum.join()}", solution: index + 14, part: :two)
  end

  defp find_code(seq, length) do
    Stream.chunk_every(seq, length, 1, :discard)
    |> Stream.with_index()
    |> Stream.drop_while(fn {chunk, _} -> length(chunk |> Enum.uniq()) != length end)
    |> Enum.at(0)
  end
end
