defmodule LiveFlipTest do
  use ExUnit.Case
  doctest LiveFlip

  test "code loaded" do
    assert Code.loaded?(LiveFlip)
  end
end
