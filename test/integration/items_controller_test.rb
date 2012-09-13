require 'test_helper'

describe ItemsController do
  include Capybara::DSL

  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:dropbox]
    User.delete_all
    Item.delete_all
  end

  it "can sign up" do
    visit root_path
    assert page.has_content? "Mil Cajas"
    VCR.use_cassette('allow_dropbox') do
      click_link "Accede con Dropbox"
    end
    assert page.has_content? "Mil Cajas"
    VCR.use_cassette('fetch_dropbox') do
      click_link "Reset"
    end
    Item.count.must_be :>, 0
  end

end