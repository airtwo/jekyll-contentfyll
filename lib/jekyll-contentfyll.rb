require 'jekyll-contentfyll/version'
require 'jekyll-contentfyll/helpers'

%w[fyll].each do |file|
  require File.expand_path("jekyll/commands/#{file}.rb", File.dirname(__FILE__))
end