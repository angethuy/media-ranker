require "test_helper"

describe IceCreamsController do
  let(:ice_cream) { ice_creams(:one) }

  it "should get index" do
    get ice_creams_url
    must_respond_with :success
  end

  it "should get new" do
    get new_ice_cream_url
    must_respond_with :success
  end

  it "should create ice_cream" do
    assert_difference("IceCream.count") do
      post ice_creams_url, params: { ice_cream: { base_flavor: @ice_cream.base_flavor, brand: @ice_cream.brand, category: @ice_cream.category, description: @ice_cream.description, name: @ice_cream.name } }
    end

    must_redirect_to ice_cream_url(IceCream.last)
  end

  it "should show ice_cream" do
    get ice_cream_url(@ice_cream)
    must_respond_with :success
  end

  it "should get edit" do
    get edit_ice_cream_url(@ice_cream)
    must_respond_with :success
  end

  it "should update ice_cream" do
    patch ice_cream_url(@ice_cream), params: { ice_cream: { base_flavor: @ice_cream.base_flavor, brand: @ice_cream.brand, category: @ice_cream.category, description: @ice_cream.description, name: @ice_cream.name } }
    must_redirect_to ice_cream_url(ice_cream)
  end

  it "should destroy ice_cream" do
    assert_difference("IceCream.count", -1) do
      delete ice_cream_url(@ice_cream)
    end

    must_redirect_to ice_creams_url
  end
end
