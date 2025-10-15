require "rgot/cli"
require "active_record"
require "active_support/all"
require "active_decorator"
require "orthoses"
require "orthoses/active_decorator"

Dir[File.expand_path("app/**/*.rb", __dir__)].each { |file| require_relative file }

class Application < Rails::Application
  config.root = File.dirname(__FILE__)
  config.eager_load = false
end
# Application.initialize!

unless $PROGRAM_NAME.end_with?("/rgot")
  at_exit do
    exit Rgot::Cli.new(["-v", "lib"]).run
  end
end
