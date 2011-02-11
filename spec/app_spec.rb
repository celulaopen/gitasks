require 'spec_helper'
require "ap"

describe Sinatra::Application do
  context "responding to GET /hi" do
    it "should return status code 200" do
      get '/hi'
      last_response.status.should == 200
    end
  end
end
