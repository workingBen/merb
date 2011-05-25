require File.expand_path("../merb-core/lib/merb-core/version.rb", __FILE__)
require File.expand_path("../merb/lib/merb/stack_info.rb", __FILE__)

require 'rubygems'

begin
  # this may be necessary for the Gem build process
  require 'psych'
rescue LoadError
end

require 'fileutils'

ROOT = File.dirname(__FILE__)

# Global options for YARD.
#
# Only specify options that are useful for rubydoc.info. Those options
# get written to the .yardopts file by the "yardopts" task.
yard_options = [
  ['--output-dir',  'doc/yard'               ],
  ['--tag',         'overridable:Overridable'],
  ['--markup',      'markdown'               ],
  ['--markup-provider', 'kramdown'           ],
  ['--exclude',     '/generators/'           ],
]

# Local options for YARD.
#
# Those options are only applied on the local "doc" and "yard" tasks.
yard_local_options = [
  ['-e', File.join(ROOT, 'yard', 'merbext.rb') ],
  ['-p', File.join(ROOT, 'yard', 'templates')  ],
  ['--no-yardopts']
]

merb_stack_gems = Merb::STACK_GEMS

def rake_command(command)
  ruby '-S', 'rake', command, :verbose => false
end

desc "Build all merb stack gems"
task :gems do
  Gem.configuration.verbose = false

  destdir = File.join(ROOT, 'pkg')
  Dir.mkdir(destdir) unless File.directory?(destdir)

  merb_stack_gems.each do |gem_info|
    gem_dir = File.join(ROOT, gem_info[:path])
    next unless File.directory?(gem_dir)

    begin
      Dir.chdir(gem_dir) do
        gspec_file = "#{gem_info[:name]}.gemspec"

        unless File.exist?(gspec_file)
          STDERR.puts "No gemfile: #{File.join(gem_dir, gspec_file)}"
          next
        end

        gspec = Gem::Specification.load("#{gem_info[:name]}.gemspec")
        fname = Gem::Builder.new(gspec).build

        if File.exist? fname
          FileUtils.mv(fname, destdir)
        end

        puts "Built gem: #{gem_info[:name]}"
      end
    rescue => e
      # maybe one of the out-of-repo gems was missing
      STDERR.puts "Error building #{gem_info[:name]}: #{e} (#{e.class})#{$/}#{e.backtrace.join($/)}"
    end
  end
end

desc "Run specs for all merb stack gems"
task :spec do
  # Omit the merb metagem, no specs there
  merb_stack_gems[0..-2].each do |gem_info|
    Dir.chdir(File.join(ROOT, gem_info[:path])) { rake_command "spec" }
  end
end

# Helper to create a parameter list for YARD.
#
# Returns an array of paths with files relevant to documentation. Since YARD
# uses a dash ("-") parameter to separate code files from auxiliary files,
# order is important.
def docfile_gen(gemlist)
  paths = gemlist.select {|g| g[:doc] == :yard}

  # add source files to documentation generation
  doc_files = paths.collect {|g| File.join(g[:name], 'lib', '**', '*.rb')}

  # add auxiliary documentation files (in gems "docs" directory)
  doc_files << '-'

  paths.each do |g|
    docs_path = File.join(g[:name], 'docs')

    if File.directory?(docs_path)
      doc_files << File.join(docs_path, '*.mkd')
    end
  end

  doc_files
end

desc "Write .yardopts file for YARD"
task :yardopts do
  File.open(File.join(ROOT, '.yardopts'), 'w') do |yardfile|
    yard_options.each do |yo|
      case yo
      when Array then yardfile.puts yo.join(' ')
      else yardfile.puts yo
      end
    end

    yardfile.puts docfile_gen(merb_stack_gems).join($/)
  end
end

begin
  require 'yard'

  YARD::Rake::YardocTask.new :doc do |t|
    t.files = docfile_gen(merb_stack_gems)
    t.options = (yard_options + yard_local_options).flatten
  end
rescue LoadError
  # just skip the Rake task if YARD is not installed
end

task :default => 'spec'
