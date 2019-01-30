module RTika
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
end
