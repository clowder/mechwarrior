# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'mechwarrior/version'

Gem::Specification.new do |s|
  s.name = "mechwarrior"
  s.version = Mechwarrior::VERSION

  s.authors = ["Chris Lowder"]
  s.email = ["clowder@gmail.com"]
  s.description = "A Mechanize based Capybara driver."

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.md)
  s.extra_rdoc_files = ["README.md"]

  s.homepage = "http://github.com/clowder/mechwarrior"
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.6"
  s.summary = "A Mechanize based Capybara driver, designed to get round the rack-test limitation of not being able to visit external (i.e. not the app your testing) websites."

  s.add_runtime_dependency("capybara", [">= 1.0.0"])
  s.add_runtime_dependency("mechanize", ['~> 2.0.0'])
  
  s.add_development_dependency("sinatra", [">= 0.9.4"])
  s.add_development_dependency("rspec", [">= 2.0.0"])
  s.add_development_dependency("launchy", [">= 0.3.5"])
  s.add_development_dependency("yard", [">= 0.5.8"])
  s.add_development_dependency("fuubar", [">= 0.0.1"])
  s.add_development_dependency("cucumber", [">= 0.10"])
end
