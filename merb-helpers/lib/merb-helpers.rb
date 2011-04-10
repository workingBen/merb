# encoding: UTF-8

require 'merb-core'

require 'i18n'
require 'active_support/core_ext/numeric/time.rb'

module Merb
  module Helpers

    @@helpers_dir   = File.dirname(__FILE__) / 'merb-helpers'
    @@helpers_files = Dir["#{@@helpers_dir}/*_helpers.rb"].collect {|h| h.match(/\/(\w+)\.rb/)[1]}

    def self.load
      require File.dirname(__FILE__) / 'merb-helpers' / 'core_ext'
      require File.dirname(__FILE__) / 'merb-helpers' / 'core_ext' / 'numeric'

      I18n.load_path = Dir[File.dirname(__FILE__) / 'merb-helpers' / 'locale' / '*.{rb,yml}']
      I18n.config.default_locale = 'en'

      if Merb::Plugins.config[:merb_helpers]
        config = Merb::Plugins.config[:merb_helpers]

        if config[:include] && !config[:include].empty?
          load_helpers(config[:include])
        else
          # This is in case someone defines an entry in the config,
          # but doesn't put in a with or without option
          load_helpers
        end

        I18n.load_path << config[:locale_path] if config.has_key?(:locale_path)
      else
        load_helpers
      end

      I18n.reload!
    end

    # Load only specific helpers instead of loading all the helpers
    def self.load_helpers(helpers = @@helpers_files)
      helpers = helpers.is_a?(Array) ? helpers : [helpers]

      # using load here allows specs to work
      helpers.each {|helper| Kernel.load(File.join(@@helpers_dir, "#{helper}.rb") )}
    end
  end
end

Merb::Helpers.load
