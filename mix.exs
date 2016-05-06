defmodule DecksetParser.Mixfile do
  use Mix.Project

  def project do
    [app: :deckset_parser,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :ex_aws, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:earmark, git: "git@github.com:binarytemple/earmark.git"},
      #{:dir_walker, git: "git@github.com:binarytemple/dir_walker.git"},
      {:httpoison, "~> 0.8.3"},
      #{:arc, "~> 0.2.2"},
      {:ex_aws, "~> 0.4.10"}
    ]
  end
end
