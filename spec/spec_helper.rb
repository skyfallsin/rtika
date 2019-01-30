require "bundler/setup"
require "rtika"
require 'pathname'

Dir[File.expand_path('rb_files/*.rb', __dir__)].each do |f|
  require_relative f
end

Dir[File.expand_path('support/**/*.rb', __dir__)].each do |f|
  require_relative f
end

RSpec.configure do |config|
  config.include FixtureHelper

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.add_setting :file_fixture_path, default: File.expand_path('fixtures', __dir__)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
