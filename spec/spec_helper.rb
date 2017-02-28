require 'simplecov'

SimpleCov.start 'rails'
require 'rspec'
require 'rails'
require 'action_view'
require 'partial_compiler'

PartialCompiler.start

require File.expand_path("../dummy/config/environment", __FILE__) 

RSpec.configure do |config|
end
