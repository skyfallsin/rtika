raise "You need JRuby to use rRTika" unless RUBY_PLATFORM =~ /java/
require 'java' 

Dir[File.join(File.dirname(__FILE__), "*.jar")].each do |jar|
  #puts "require #{jar}"
  require jar
end

module RTika
  import org.apache.tika.sax.BodyContentHandler
  import org.apache.tika.parser.AutoDetectParser
  import org.apache.tika.metadata.Metadata

  class ParsedResult
    attr_accessor :content, :metadata
    def initialize(content, metadata)
      @content, @metadata = content, metadata
    end

    def content
      @content.to_string
    end

    def title
      @metadata.get(Metadata::TITLE)
    end

    def author
      @metadata.get(Metadata::AUTHOR)
    end

    def content_type
      @metadata.get(Metadata::CONTENT_TYPE)
    end

    def filename
      @metadata.get("filename")
    end
  end

  class GenericParser
    def self.parse(*args)
      new(*args).parse
    end

    def parse
      @parser = RTika::AutoDetectParser.new
      content, metadata = process
      RTika::ParsedResult.new(content, metadata)
    end

    def process
      raise "override this in your parser, return content and metadata" 
    end
  end

  class StringParser < GenericParser
    def initialize(string)
      @input_string = string
    end

    def process
      input_stream = java.io.ByteArrayInputStream.new(@input_string.to_java.get_bytes)
      content = RTika::BodyContentHandler.new(-1)
      metadata = RTika::Metadata.new

      @parser.parse(input_stream, content, metadata)
      input_stream.close

      return [content, metadata]
    end
  end

  class FileParser < GenericParser 
    def initialize(filename)
      @filename = filename
    end

    def process 
      input_stream = java.io.FileInputStream.new(java.io.File.new(@filename))
      content =  RTika::BodyContentHandler.new(-1)
      metadata = RTika::Metadata.new
      metadata.set("filename", File.basename(@filename))

      @parser.parse(input_stream, content, metadata)
      input_stream.close

      return [content, metadata]
    end
  end

	class UrlParser < GenericParser 
    def initialize(url, content)
      @url = url
      @content = content
    end

    def process 
      input_stream = java.io.ByteArrayInputStream.new(@content.to_java.get_bytes)
      content =  RTika::BodyContentHandler.new(-1)
      metadata = RTika::Metadata.new
      metadata.set("filename", File.basename(@url))

      @parser.parse(input_stream, content, metadata)
      input_stream.close

      return [content, metadata]
    end
  end  
end
