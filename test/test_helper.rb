ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"
require "minitest/rails/capybara"
require "capybara"
require 'vcr'
require "minitest/pride"

class MiniTest::Rails::ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end


 OmniAuth.config.mock_auth[:dropbox] = OmniAuth::AuthHash.new ({
    :provider => 'dropbox',
    :uid      => '123545',
    :secret   => 'agent',
    :token    => 'test_token',
    :info     => {
      :email   => 'superman@justiceleague.com',
      :name    => 'Superman'
    }
  })
