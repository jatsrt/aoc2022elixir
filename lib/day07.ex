defmodule Aoc2022elixir.Day07 do
  require Logger

  def run(contents) do
    %{contents: contents} =
      Enum.reduce(contents |> String.split("\n"), %{current: [], contents: %{}}, &commands/2)

    solution =
      Enum.filter(contents, fn {_, %{size: size}} -> size <= 100_000 end)
      |> Enum.map(fn {_, %{size: size}} -> size end)
      |> Enum.sum()

    Logger.info("solved", solution: solution, part: :one)

    %{size: used} = Map.get(contents, ["/"])

    {_, %{size: solution}} =
      Enum.filter(contents, fn {_, %{size: size}} -> 40_000_000 >= used - size end)
      |> Enum.min_by(fn {_, %{size: size}} -> size end)

    Logger.info("solved", solution: solution, part: :two)
  end

  defp commands("$ cd ..", %{current: [_ | t]} = acc), do: %{acc | current: t}
  defp commands("$ cd " <> dir, %{current: current} = acc), do: %{acc | current: [dir | current]}
  defp commands("$ ls", acc), do: acc
  defp commands("dir " <> _, acc), do: acc

  defp commands(file, %{current: current} = acc),
    do: update_sizes(current, String.split(file, " ") |> Enum.at(0) |> String.to_integer(), acc)

  defp update_sizes([_ | t] = current, size, %{contents: contents} = acc) do
    %{size: current_size} = Map.get(contents, current, %{size: 0})
    contents = Map.put(contents, current, %{size: current_size + size})
    update_sizes(t, size, %{acc | contents: contents})
  end

  defp update_sizes([], _, acc), do: acc
end
