require 'rubygems'
require 'stringio'

# Use current merb-core sources if running from a typical dev checkout.
lib = File.expand_path('../../../merb-core/lib', __FILE__)
$LOAD_PATH.unshift(lib) if File.directory?(lib)
require 'merb-core'

# The lib under test
require "merb-param-protection"

# Satisfies Autotest and anyone else not using the Rake tasks
require 'rspec'

# Additional files required for specs
require "controllers/param_protection"

Merb::Config[:log_stream] = StringIO.new
Merb.start :environment => 'test'

RSpec.configure do |config|
  config.include Merb::Test::ControllerHelper
  config.include Merb::Test::RequestHelper
end
