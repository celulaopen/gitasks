require 'rubygems'
require 'sinatra'
require 'bundler'

require './app'

Bundler.require

run Sinatra::Application
