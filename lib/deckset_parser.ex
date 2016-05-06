defmodule DecksetParser do

  import Earmark 
  require Logger
  use ExAws.S3.Client

  @doc "per module callback requeired by ExAws macros"
  def config_root do
    Application.get_all_env(:ex_aws)
  end

  @doc "This function lists all AWS S3 buckets associated with the account" 
  @type list_aws_buckets() :: [String.t]
  def list_aws_buckets() do
    for {:ok, res} <- [ExAws.S3.list_buckets],
        {parsed,_} <- [:xmerl_scan.string(String.to_char_list( res[:body]))],
        {_,_,_,_,name,:text} <- :xmerl_xpath.string('/ListAllMyBucketsResult/Buckets/Bucket/Name/text()',parsed),
        do: name
  end

  def find_files(root \\ "priv" , path \\ "priv/test-resources/elixirpresentation/**/*", callback \\ nil ) do
      files = for file <- Path.wildcard(path),
      File.dir?(file) == false,  
      tail <- [String.replace_leading(file,root,"")],
      do: {file,tail}
      files
  end

  def aws_upload_all_files() do 
    for {path,name} <- DecksetParser.find_files,
    do: DecksetParser.aws_put_file("binarytemple-deckset-parser",path,name)
  end

#  def aws_upload_and_transform_all_files() do
#    for {path,name} <- DecksetParser.find_files,
#    do: DecksetParser.aws_put_file("binarytemple-deckset-parser",path,name)
#  end

   defp get_content_type(path) do
     case Path.extname(path) do
          ".jpg" ->  "image/jpg"
          ".png" -> "image/png"
          ".gif" -> "image/gif"
          ".html" -> "text/html"
          ".md" -> "text/markdown"
          ".markdown" -> "text/markdown"
          _ -> "application/octet-stream"
     end
  end

  def aws_put_content(bucket,name,content,content_type,content_length) do
    Logger.debug "#{bucket}, #{name}, #{content_type}, #{content_length}"
    put_object(bucket, name, content, [{:content_type, content_type}, {:content_length, content_length}])
  end

  def aws_put_file(bucket,path,name) do
    {:ok,content} = File.read(path)
    {:ok, stat} = File.stat(path)
    content_length  = stat.size |> Integer.to_string

    case get_content_type(path) do
        "text/markdown" ->
            html_content=convert_to_markdown(content)

            html_name=Path.rootname(name) <> ".html"
            html_content_length=byte_size(html_content)
            aws_put_content(bucket,html_name,html_content,"text/html; charset=utf-8",html_content_length)
            put_object(bucket, name, content, [{:content_type, "text/markdown; charset=utf-8"}, {:content_length, content_length}])

        other -> put_object(bucket, name, content, [{:content_type, other}, {:content_length, content_length}])
    end

    #Logger.debug "#{bucket}, #{name}, #{content_type}, #{content_length}"
  end

  def convert_to_markdown(content) do
      """
       <html>
       <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
       <title>converted markdown</title>
       </head>
       <body>
       #{Earmark.to_html(content)}
       </body>
      """
  end

end