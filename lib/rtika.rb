raise "You need JRuby to use rRTika" unless RUBY_PLATFORM =~ /java/
require 'java'

Dir[File.join(File.dirname(__FILE__), "../ext/*.jar")].each do |jar|
  require jar
end

module RTika
  import org.apache.tika.parser.html.BoilerpipeContentHandler
  import org.apache.tika.sax.BodyContentHandler
  import org.apache.tika.sax.WriteOutContentHandler
  import org.apache.tika.parser.AutoDetectParser
  import org.apache.tika.metadata.Metadata
  import org.apache.tika.config.TikaConfig
end

require "rtika/version"
require "rtika/parsed_result"
require "rtika/generic_parser"
require "rtika/file_parser"
require "rtika/url_parser"
require "rtika/string_parser"
