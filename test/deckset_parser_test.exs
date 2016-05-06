defmodule DecksetParserTest do
  use ExUnit.Case
#  doctest DecksetParser

  test "that Earmark is working" do
    Earmark.to_html("# foo") == "<h1>foo</h1>\n"
  end

  test "that Earmark nicely converts the content" do
      {:ok,source} =File.read("./priv/test-resources/elixirpresentation/presentation-we-work-28-04-2016-elixir-plug-docker.md")
      converted = DecksetParser.convert_to_markdown(
        source
      )
      #pointless .. but a start...
      assert converted  == converted
  end

end