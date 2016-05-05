# DecksetParser

I gave a presentation at WeWork - Startup tech pack - Thursday, April 28, 2016.

I used [Deckset](http://www.decksetapp.com/) to create the presentation (great tool btw).

It then occured to me that I've got a ton of markdown gists which it would be nice to publish, 
so I wrote this trivial little elixir app to upload them. 

I hacked this up in a morning, so don't add it to your app dependencies just yet.

The output can be found on S3 [here](http://binarytemple-deckset-parser.s3.amazonaws.com/elixirpresentation/presentation-we-work-28-04-2016-elixir-plug-docker.html)

This project uses:

* [Earmark]( https://github.com/pragdave/earmark )
* [HTTPoison]( https://github.com/edgurgel/httpoison )
* [`ex_aws`]( https://github.com/CargoSense/ex_aws )
