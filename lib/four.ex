defmodule AOC24.Four do
  alias AOC24.Utils

  @directions [
    [{1, 0}, {2, 0}, {3, 0}],
    [{1, 1}, {2, 2}, {3, 3}],
    [{0, 1}, {0, 2}, {0, 3}],
    [{0, -1}, {0, -2}, {0, -3}],
    [{-1, -1}, {-2, -2}, {-3, -3}],
    [{-1, 0}, {-2, 0}, {-3, 0}],
    [{1, -1}, {2, -2}, {3, -3}],
    [{-1, 1}, {-2, 2}, {-3, 3}]
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
        direction <- @directions do
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

  def second(_) do
    :not_implemented
  end
end
