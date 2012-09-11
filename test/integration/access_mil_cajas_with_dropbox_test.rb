require 'test_helper'

describe "Access MilCajas through Welcome" do

  it "access home panel" do
    visit root_path
    assert page.has_selector?('a#gotopanel')
  end

end
