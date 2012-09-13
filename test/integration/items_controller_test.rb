require 'test_helper'

describe ItemsController do
  include Capybara::DSL

  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:dropbox]
  end

  it "can sign up" do
    visit root_path
    assert page.has_content? "Mil Cajas"
    click_link "Accede con Dropbox"
    assert page.has_content? "Mil Cajas"
    click_link "Reset"
    Item.count.must_be :>, 0
  end

end