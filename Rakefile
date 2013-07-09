# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "tictail"
  gem.homepage = "http://github.com/evanwhalen/tictail-ruby"
  gem.license = "MIT"
  gem.summary = %Q{Tictail API client}
  gem.description = %Q{Use this Tictail API client to interact with Tictail API}
  gem.email = "evanwhalendev@gmail.com"
  gem.authors = ["Evan Whalen"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new