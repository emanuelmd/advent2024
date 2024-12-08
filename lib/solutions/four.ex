defmodule AOC24.Four do
  alias AOC24.Utils

  @word_directions [
    [{1, 0}, {2, 0}, {3, 0}],
    [{1, 1}, {2, 2}, {3, 3}],
    [{0, 1}, {0, 2}, {0, 3}],
    [{0, -1}, {0, -2}, {0, -3}],
    [{-1, -1}, {-2, -2}, {-3, -3}],
    [{-1, 0}, {-2, 0}, {-3, 0}],
    [{1, -1}, {2, -2}, {3, -3}],
    [{-1, 1}, {-2, 2}, {-3, 3}]
  ]

  @diagonals [
    [{-1, -1}, {0, 0}, {1, 1}],
    [{1, -1}, {0, 0}, {-1, 1}]
  ]

  def input do
    Utils.raw_input("four")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  def first(input) do
    height = Enum.count(input)
    width = input |> Enum.at(0) |> Enum.count()

    for {row, y} <- Enum.with_index(input),
        {?X, x} <- Enum.with_index(row),
        direction <- @word_directions do
      word =
        Enum.map(direction, fn {xx, yy} ->
          at_y = y + yy
          at_x = x + xx

          if at_y >= 0 and at_y < height and at_x >= 0 and at_x < width do
            get_in(
              input,
              [Access.at(at_y), Access.at(at_x)]
            )
          end
        end)

      case word do
        ~c"MAS" ->
          1

        _ ->
          0
      end
    end
    |> Enum.sum()
  end

  def second(input) do
    height = Enum.count(input)
    width = input |> Enum.at(0) |> Enum.count()

    for {row, y} <- Enum.with_index(input),
        {?A, x} <- Enum.with_index(row) do
      diagonal_words =
        Enum.map(@diagonals, fn cords ->
          Enum.map(cords, fn {xx, yy} -> get_at(input, height, width, x + xx, y + yy) end)
        end)

      if Enum.all?(diagonal_words, &(&1 in [~c"SAM", ~c"MAS"])) do
        1
      else
        0
      end
    end
    |> Enum.sum()
  end

  defp get_at(input, height, width, x, y) do
    if x >= 0 and x < width and y >= 0 and y < height do
      get_in(input, [Access.at(y), Access.at(x)])
    end
  end
end
