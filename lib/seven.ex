defmodule AOC24.Seven do
  def input do
    AOC24.Utils.raw_input("seven")
    |> parse_input()
  end

  def first(input) do
    sum_matching(input, [?+, ?*])
  end

  def second(input) do
    sum_matching(input, [?+, ?*, ?|])
  end

  defp sum_matching(input, operators) do
    Enum.reduce(input, 0, fn {total, numbers}, acc ->
      perms = Enum.count(numbers) - 1

      match? =
        operators
        |> permutations(perms)
        |> Enum.map(&evaluate(numbers, &1))
        |> Enum.any?(&(&1 == total))

      if match? do
        total + acc
      else
        acc
      end
    end)
  end

  def permutations(_list, 0), do: [[]]

  def permutations(list, k) do
    for x <- list, y <- permutations(list, k - 1) do
      [x | y]
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [result, operators] = String.split(line, ": ", parts: 2)

      operators =
        operators
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)

      {String.to_integer(result), operators}
    end)
  end

  defp evaluate([result], []) do
    result
  end

  defp evaluate([left, right | rest], [operator | rest_op]) do
    result =
      case operator do
        ?+ ->
          left + right

        ?* ->
          left * right

        ?| ->
          (Integer.to_string(left) <> Integer.to_string(right))
          |> String.to_integer()
      end

    evaluate([result | rest], rest_op)
  end
end
