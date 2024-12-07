defmodule AOC24.Six do
  defstruct [:matrix, :position, :direction, :height, :width]

  @guard_chars ~c"^><v"

  def input do
    AOC24.Utils.raw_input("six")
    |> parse_input()
  end

  def first(input) do
    total_steps =
      Stream.unfold(input, fn state ->
        case iterate(state) do
          :outside -> nil
          new_state -> {new_state.position, new_state}
        end
      end)
      |> MapSet.new()
      |> Enum.count()

    # Outside step should not be counted
    total_steps - 1
  end

  def second(input) do
    :ok
  end

  defp iterate(
         %__MODULE__{
           matrix: m,
           position: {x, y},
           direction: dir,
           height: height,
           width: width
         } = state
       ) do
    next = next_position({x, y}, dir)

    cond do
      x >= width or y >= height ->
        :outside

      obstacle?(m, next) ->
        change_direction(state)

      true ->
        %{state | position: next}
    end
  end

  defp next_position({x, y}, dir) do
    case dir do
      ?^ -> {x, y - 1}
      ?v -> {x, y + 1}
      ?> -> {x + 1, y}
      ?< -> {x - 1, y}
    end
  end

  defp change_direction(%__MODULE__{direction: dir} = state) do
    new_direction =
      case dir do
        ?^ -> ?>
        ?> -> ?v
        ?v -> ?<
        ?< -> ?^
      end

    %__MODULE__{state | direction: new_direction}
  end

  defp obstacle?(matrix, {x, y}) do
    char =
      matrix
      |> Enum.at(y, [])
      |> Enum.at(x)

    char == ?#
  end

  defp parse_input(input) do
    matrix =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist/1)

    y =
      Enum.find_index(matrix, fn row ->
        Enum.any?(row, &(&1 in @guard_chars))
      end)

    x =
      matrix
      |> Enum.at(y)
      |> Enum.find_index(&(&1 in @guard_chars))

    guard_direction =
      matrix
      |> Enum.at(y)
      |> Enum.at(x)

    height = Enum.count(matrix)

    width =
      matrix
      |> Enum.at(0)
      |> Enum.count()

    %__MODULE__{
      matrix: matrix,
      position: {x, y},
      direction: guard_direction,
      height: height,
      width: width
    }
  end
end
