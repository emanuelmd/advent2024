defmodule AOC24.Utils do
  def raw_input(day) do
    Application.app_dir(:aoc24, "priv/input/#{day}.txt")
    |> File.read!()
  end
end
