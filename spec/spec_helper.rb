require "rubygems"
require 'rspec'

require File.expand_path("../../merb/lib/merb/stack_info", __FILE__)

RSpec.configure do |config|
  def plugin_path(relative_path, *elements)
    subpath = File.join(relative_path, *elements)
    File.expand_path(File.join('../../', subpath), __FILE__)
  end
end
