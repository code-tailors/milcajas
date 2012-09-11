require 'test_helper'

describe Sharebox::Application do

  it "should be present" do
    refute_nil ENV['APP_KEY']
    refute_nil ENV['APP_SECRET']
  end

end