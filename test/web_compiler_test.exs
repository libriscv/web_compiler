defmodule WebCompilerTest do
  use ExUnit.Case
  doctest WebCompiler

  test "greets the world" do
    assert WebCompiler.hello() == :world
  end
end
