defmodule DecksetParserTest do
  use ExUnit.Case
  doctest DecksetParser

  test "that Earmark is working" do
    Earmark.to_html "# foo" == "<h1>foo</h1>"
  end
end