module Merb
  # List of gems in the Merb stack.
  #
  # The `:path` entry is relative to a root in a common development
  # environment where all gems are residing under a common directory.
  #
  # @note Make sure that merb-core is always the first element.
  STACK_GEMS = [
    { :name => 'merb-core',             :path => "merb-core",             :doc => :yard, :repo => 'merb' },
    { :name => 'merb-action-args',      :path => "merb-action-args",      :doc => :yard, :repo => 'merb' },
    { :name => 'merb-assets',           :path => "merb-assets",           :doc => :yard, :repo => 'merb' },
    { :name => 'merb-slices',           :path => "merb-slices",           :doc => :yard, :repo => 'merb' },
    { :name => 'merb-cache',            :path => "merb-cache",            :doc => :yard, :repo => 'merb' },
    { :name => 'merb-gen',              :path => "merb-gen",              :doc => :yard, :repo => 'merb' },
    { :name => 'merb-haml',             :path => "merb-haml",             :doc => :yard, :repo => 'merb' },
    { :name => 'merb-helpers',          :path => "merb-helpers",          :doc => :yard, :repo => 'merb' },
    { :name => 'merb-mailer',           :path => "merb-mailer",           :doc => :yard, :repo => 'merb' },
    { :name => 'merb-param-protection', :path => "merb-param-protection", :doc => :yard, :repo => 'merb' },
    { :name => 'merb-exceptions',       :path => "merb-exceptions",       :doc => :yard, :repo => 'merb' },
    { :name => 'merb-auth',             :path => "../merb-auth",          :doc => :rdoc, :repo => 'merb-auth' },
    { :name => 'merb_datamapper',       :path => "../merb_datamapper",    :doc => :rdoc, :repo => 'merb_datamapper' },
    { :name => 'merb',                  :path => "merb",                  :doc => :rdoc, :repo => 'merb' }
  ]
end

