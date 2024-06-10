defmodule PrimosTest do
  use ExUnit.Case
  doctest Primos

  test "greets the world" do
    assert Primos.hello() == :world
  end
end
