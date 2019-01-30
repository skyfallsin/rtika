module RTika
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
