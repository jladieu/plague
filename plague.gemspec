# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'plague/version'

Gem::Specification.new do |s|
  s.name        = 'plague'
  s.version     = Plague::VERSION
  s.summary     = 'Helps determine if two files have any plagiarized content'
  s.description = 'Helps determine if two files have any plagiarized content'
  s.authors     = ['Josh Ladieu']
  s.email       = 'josh.ladieu@gmail.com'
  s.files       = Dir['lib/**/*.rb'] + Dir['config/**/*.yml']

  s.add_development_dependency('rspec-rails')
  s.add_development_dependency('rails', '3.2.6')
  s.add_development_dependency('rspec', '~> 2.11.0')
  s.add_development_dependency('mocha', '~> 0.11.4')
end
