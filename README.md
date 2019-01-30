rTika
========

A JRuby wrapper around the excellent Apache Tika content extraction library.
Feed rTika your files and get extracted text and metadata in return.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rtika'
```

And then execute:

    $ bundle

Or install it yourself as:
    $ gem install rtika

## Usage

Make sure you're on JRuby first.

```ruby
  require 'rubygems'
  require 'rtika'

  result = RTika::FileParser.parse("mywordfile.doc")
  puts result.content # prints out the document's contents
  puts result.title   # fetches title from the doc's metadata
  puts result.author  # fetches author from the doc's metadata

  result = RTika::StringParser.parse("<html>
                <head><title>MYTITLE</title></head>
                <body>this is my very ... long ... string</body></html>")
  puts result.content # returns <body> contents
  puts result.title   # returns <title> contents
```

Options `:remove_boilerplate => true` uses the Boilerpipe library that ships with Tika to remove headers & footers.
Options `tika_config: 'path/to/tika_config.xml'` configures parsers and detectors. More [here](https://tika.apache.org/1.9/configuring.html).

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010-2019 Pradeep Elankumaran. See LICENSE for details.
