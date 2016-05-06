use Mix.Config

# config :deckset_parser, aws_bucket: :elixirpresentation

#config :arc,
#  bucket: "binarytemple-deckset-parser",
#  virtual_host: true

config :ex_aws,
  access_key_id: (System.get_env("DECKSET_PARSER_AWS_ACCESS_KEY_ID") || raise "missing env var DECKSET_PARSER_AWS_ACCESS_KEY_ID"),
  secret_access_key: (System.get_env("DECKSET_PARSER_AWS_SECRET_ACCESS_KEY") || raise "raise missing env var DECKSET_PARSER_AWS_SECRET_ACCESS_KEY"),
  s3: [
    scheme: "https://",
    host: "s3-eu-west-1.amazonaws.com",
    region: "eu-west-1"
  ]
