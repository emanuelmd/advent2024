defmodule AOC24.Three do
  alias AOC24.ParserC

  def input do
    AOC24.Utils.raw_input("three")
  end

  def first(input) do
    input
    |> parse()
    |> eval(:ignore_cond)
    |> Enum.sum()
  end

  def second(input) do
    input
    |> parse()
    |> eval(:do)
    |> Enum.sum()
  end

  def parse(<<"mul(" <> _::binary>> = input) do
    case match_mul(input) do
      {:ok, {x, y}, rest} -> [{:mul, x, y} | parse(rest)]
      {:error, rest} -> parse(rest)
    end
  end

  def parse(<<"do()", rest::binary>>) do
    [:do | parse(rest)]
  end

  def parse(<<"don't()", rest::binary>>) do
    [:dont | parse(rest)]
  end

  def parse(<<_, rest::binary>>) do
    parse(rest)
  end

  def parse("") do
    []
  end

  def match_mul(<<"mul(" <> input::binary>>) do
    with {:ok, x, rest} <- ParserC.number(input, 3),
         {:ok, rest} <- ParserC.char(rest, 44),
         {:ok, y, rest} <- ParserC.number(rest, 3),
         {:ok, rest} <- ParserC.char(rest, 41) do
      {:ok, {x, y}, rest}
    end
  end

  def eval([], _), do: []

  def eval([elem | rest], :ignore_cond) do
    case elem do
      {:mul, x, y} -> [x * y | eval(rest, :ignore_cond)]
      :do -> eval(rest, :ignore_cond)
      :dont -> eval(rest, :ignore_cond)
    end
  end

  def eval([:dont | rest], _) do
    eval(rest, :dont)
  end

  def eval([:do | rest], _) do
    eval(rest, :do)
  end

  def eval([{:mul, x, y} | rest], :do) do
    [x * y | eval(rest, :do)]
  end

  def eval([_ | rest], :dont) do
    eval(rest, :dont)
  end
end
