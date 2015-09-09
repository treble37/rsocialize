require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'rsocialize'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
end
