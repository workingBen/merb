module Merb::Generators
  class Mailer < NamespacedGenerator

    include AppGeneratorHelpers

    source_paths << File.join(File.dirname(__FILE__), 'templates', 'mailer')

    desc 'Create a mailer'

    class_option_for :testing_framework

    register

    def create_mailer
      directory 'app'
      directory 'spec' if options[:testing_framework] == :rspec
    end

  end
end
