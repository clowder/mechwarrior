require 'rubygems'
require 'bundler/setup'

require 'capybara/cucumber'
require 'capybara/spec/test_app'
require 'mechwarrior/cucumber'

Capybara.app = TestApp
