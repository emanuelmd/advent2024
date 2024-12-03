defmodule AOC24.ParserC do
  @moduledoc """
  Basic parser combinator constructs
  """

  def number(inpt, count) do
    number(inpt, count, [])
  end

  def number(rest, count, acc) when count == 0 do
    if Enum.empty?(acc) do
      {:error, rest}
    else
      number =
        acc
        |> Enum.reverse()
        |> to_string()
        |> String.to_integer()

      {:ok, number, rest}
    end
  end

  def number(<<char, rest::binary>>, count, acc) when char in 48..57 do
    number(rest, count - 1, [char | acc])
  end

  def number(rest, _, acc) do
    number(rest, 0, acc)
  end

  def char(<<c, rest::binary>>, c), do: {:ok, rest}

  def char(rest, _) do
    {:error, rest}
  end
end
