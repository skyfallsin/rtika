module RTika
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
end
