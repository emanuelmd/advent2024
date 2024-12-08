defmodule AOC24.Two do
  def input do
    AOC24.Utils.raw_input("two")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true) |> Enum.map(&String.to_integer/1)
    end)
  end

  def first(input) do
    Enum.count(input, &(row_faults(&1) == 0))
  end

  def second(input) do
    Enum.count(input, &(row_faults(&1) <= 1))
  end

  defp row_faults([first, next | rest]) do
    direction =
      if first > next, do: :desc, else: :asc

    row_faults([first, next | rest], direction, 0)
  end

  defp row_faults([first, next | rest], direction, faults) do
    direction_ok? =
      case direction do
        :asc -> first < next
        :desc -> first > next
      end

    diff_ok? = abs(first - next) in [1, 2, 3]

    faults = if direction_ok? and diff_ok?, do: faults, else: faults + 1

    row_faults([next | rest], direction, faults)
  end

  defp row_faults(_, _, faults), do: faults
end
