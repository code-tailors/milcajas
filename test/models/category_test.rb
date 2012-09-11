require "test_helper"

describe Category do
  before do
    @category = Category.new
  end

  it "must be valid" do
    @category.valid?.must_equal true
  end
end
