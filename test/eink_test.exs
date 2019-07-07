defmodule EinkTest do
  use ExUnit.Case
  doctest Eink

  test "greets the world" do
    assert Eink.hello() == :world
  end
end
