require 'rubygems'
require 'rspec'
require 'rspec/autorun'
require 'mocha'

require 'plague'

RSpec.configure do |config|
  config.mock_framework = :mocha
end


