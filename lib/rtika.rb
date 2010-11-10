raise "You need JRuby to use rRTika" unless RUBY_PLATFORM =~ /java/
require 'java' 

Dir[File.join(File.dirname(__FILE__), "*.jar")].each do |jar|
  #puts "require #{jar}"
  require jar
end

module RTika
  import org.apache.tika.parser.html.BoilerpipeContentHandler
  import org.apache.tika.sax.BodyContentHandler
  import org.apache.tika.sax.WriteOutContentHandler
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

    def remove_boilerplate?
      @options[:remove_boilerplate] && @options[:remove_boilerplate] == true 
    end

    def initialize(*args)
      @options = args.last 

      if remove_boilerplate? 
        @writeout_content = RTika::WriteOutContentHandler.new(-1)
        @content = RTika::BoilerpipeContentHandler.new(@writeout_content)
      else
        @content = RTika::BodyContentHandler.new(-1)
      end

      @metadata = RTika::Metadata.new
    end

    def parse
      @parser = RTika::AutoDetectParser.new
      @content, @metadata = process
      
      if remove_boilerplate? 
        RTika::ParsedResult.new(@writeout_content, @metadata)
      else
        RTika::ParsedResult.new(@content, @metadata)
      end
    end

    def process
      raise "override this in your parser, return content and metadata" 
    end
  end

  class StringParser < GenericParser
    def initialize(string, opts={})
      super(opts)
      @input_string = string
    end

    def process
      input_stream = java.io.ByteArrayInputStream.new(@input_string.to_java.get_bytes)

      @parser.parse(input_stream, @content, @metadata)
      input_stream.close

      return [@content, @metadata]
    end
  end

  class FileParser < GenericParser 
    def initialize(filename, opts={})
      super(opts)
      @filename = filename
    end

    def process 
      input_stream = java.io.FileInputStream.new(java.io.File.new(@filename))
      @metadata.set("filename", File.basename(@filename))

      @parser.parse(input_stream, @content, @metadata)
      input_stream.close

      return [@content, @metadata]
    end
  end

	class UrlParser < GenericParser 
    def initialize(url, content, opts={})
      super(opts)
      @url = url
      @url_content = content
    end

    def process 
      input_stream = java.io.ByteArrayInputStream.new(@url_content.to_java.get_bytes)
      @metadata.set("filename", File.basename(@url))

      @parser.parse(input_stream, @content, @metadata)
      input_stream.close

      return [@content, @metadata]
    end
  end  
end
