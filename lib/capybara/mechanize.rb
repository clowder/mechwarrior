require 'capybara'

module Capybara
  module Mechanize
    autoload :Driver,  'capybara/mechanize/driver'
    autoload :Node,    'capybara/mechanize/node'
    autoload :Form,    'capybara/mechanize/form'
  end
end

if Capybara.respond_to?(:register_driver)
  Capybara.register_driver :mechanize do |app|
    Capybara::Mechanize::Driver.new(app)
  end
end