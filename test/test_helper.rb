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
  #allow_http_connections_when_no_cassette = true
  c.ignore_localhost = true
end


 OmniAuth.config.mock_auth[:dropbox] = OmniAuth::AuthHash.new ({
    :provider => "dropbox",
    :uid      => 3810241,
    :credentials => {
      :secret   => "u7mnci2j45y7dvd",
      :token    => "6gx2428ks90zvti"
    },
    :info     => {
      :email   => "superman@justiceleague.com",
      :name    => "Superman"
    }
  })

#Support JS
#Capybara.default_driver = :selenium
Capybara.default_driver =  :webkit

Dir[Rails.root.join("test/support/**/*.rb")].each {|f| require f}