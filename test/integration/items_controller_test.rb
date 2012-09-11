require 'test_helper'

describe ItemsController do
  include Capybara::DSL

  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:dropbox]
  end

  it "can sign up" do
    #VCR.use_cassette('synopsis') do
    visit root_path
    assert page.has_content? "Mil Cajas"
    #end
  end

end