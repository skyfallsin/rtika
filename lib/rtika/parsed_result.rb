module RTika
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
end
