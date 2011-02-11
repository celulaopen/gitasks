require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  #conf.before(:each) { DataMapper.auto_migrate! }
end

def app
  Sinatra::Application
end