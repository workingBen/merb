# encoding: utf-8

require 'spec_helper'

shared_examples_for "a loadable plugin" do |plugin_info|
  it "should be possible to load both a gem and its version.rb" do
    plugin = plugin_info[:path]
    lib_dir = plugin_path(plugin)

    if File.directory?(lib_dir) && File.exist?(File.join(lib_dir, 'lib', plugin_info[:name], 'version.rb'))
      $LOAD_PATH.unshift(File.join(lib_dir, 'lib'))
    else
      pending "No plugin found or missing version.rb at #{lib_dir}"
    end

    expect do
      require File.join(plugin_info[:name], 'version')
      require plugin_info[:name]
    end.to_not raise_error
  end
end

Merb::STACK_GEMS.each do |gem_info|
  describe gem_info[:name] do
    it_should_behave_like "a loadable plugin", gem_info
  end
end
