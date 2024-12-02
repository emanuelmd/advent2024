defmodule AOC24 do
  @spec run(String.t()) :: any()
  def run(day) do
    mod = Module.concat([AOC24, Macro.camelize(day)])

    input = mod.input()

    first = mod.first(input) |> inspect
    second = mod.second(input) |> inspect

    IO.puts("Day #{day}")
    IO.puts("1. #{first}")
    IO.puts("2. #{second}")

    :ok
  end
end
