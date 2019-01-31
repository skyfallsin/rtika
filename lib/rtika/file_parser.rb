module RTika
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
end
