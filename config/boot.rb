ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
ENV['NLS_LANG'] = 'AMERICAN_AMERICA.UTF8'