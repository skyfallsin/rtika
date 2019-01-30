require 'pathname'

module RbFiles
  class BaseFile
    def fixture_dir
      @fixture_dir ||= Pathname.new File.expand_path('../fixtures', __dir__)
    end

    def name
      ""
    end

    def path
      fixture_dir.join(name)
    end

    def pages
      []
    end
  end
end
