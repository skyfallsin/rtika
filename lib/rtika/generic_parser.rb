module RTika
  class GenericParser
    def self.parse(*args)
      new(*args).parse
    end

    def remove_boilerplate?
      @options[:remove_boilerplate] && @options[:remove_boilerplate] == true
    end

    def use_custom_tika_config?
      @options.key? :tika_config
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
      @parser = build_parser
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

    private

    def build_parser
      use_custom_tika_config? ? build_custom_parser : build_default_parser
    end

    def build_custom_parser
      config = RTika::TikaConfig.new @options[:tika_config]
      detector = config.getDetector

      RTika::AutoDetectParser.new config
    end

    def build_default_parser
      RTika::AutoDetectParser.new
    end
  end
end
