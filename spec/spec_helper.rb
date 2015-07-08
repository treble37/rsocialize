require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'rsocialize'

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
end
