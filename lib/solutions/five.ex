defmodule AOC24.Five do
  defstruct [:rules, :updates]

  def input do
    AOC24.Utils.raw_input("five")
    |> parse_input()
  end

  def first(%__MODULE__{rules: rules, updates: updates}) do
    updates
    |> Enum.reduce([], fn update, acc ->
      if update_correct?(Enum.reverse(update), rules) do
        [middle_page(update) | acc]
      else
        acc
      end
    end)
    |> Enum.sum()
  end

  def second(_) do
    :not_ok
  end

  defp parse_input(input) do
    {rules, updates} =
      input
      |> String.split("\n")
      |> Enum.split_while(&(&1 != ""))

    rules =
      Enum.reduce(rules, %{}, fn line, acc ->
        [left, right] =
          line
          |> String.split("|")
          |> Enum.map(&String.to_integer/1)

        Map.update(acc, left, [right], &[right | &1])
      end)

    updates =
      Enum.map(updates, fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.filter(&(not Enum.empty?(&1)))

    %__MODULE__{rules: rules, updates: updates}
  end

  defp middle_page(updates) do
    middle_index =
      updates
      |> Enum.count()
      |> div(2)

    Enum.at(updates, middle_index)
  end

  defp update_correct?([], _), do: true

  defp update_correct?([page | rest], rules) do
    page_rules =
      Map.get(rules, page, [])
      |> MapSet.new()

    intersection =
      rest
      |> MapSet.new()
      |> MapSet.intersection(page_rules)

    Enum.empty?(intersection) and update_correct?(rest, rules)
  end
end
