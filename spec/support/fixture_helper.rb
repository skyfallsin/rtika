module FixtureHelper
  def pathname_fixture(path)
    pathname = Pathname.new ::RSpec.configuration.file_fixture_path
    pathname.join(path)
  end

  def file_fixture(path)
    pathname_fixture(path).open
  end

  def fixture_file_upload(path, mime_type = nil, _binary = false)
    Rack::Test::UploadedFile.new(pathname_fixture(path).to_s, mime_type)
  end
end
