defmodule AOC24.One do
  def input do
    {left, right} =
      AOC24.Utils.raw_input("one")
      |> String.split("\n", trim: true)
      |> Enum.reduce({[], []}, fn line, {left_acc, right_acc} ->
        [left, right] = String.split(line, " ", trim: true) |> Enum.map(&String.to_integer/1)

        {[left | left_acc], [right | right_acc]}
      end)

    {Enum.reverse(left) |> Enum.sort(), Enum.reverse(right) |> Enum.sort()}
  end

  def first({left, right}) do
    Enum.zip_with(left, right, &abs(&1 - &2))
    |> Enum.sum()
  end

  def second({left, right}) do
    right_freq = Enum.frequencies(right)

    left
    |> Enum.map(&(&1 * Map.get(right_freq, &1, 0)))
    |> Enum.sum()
  end
end
