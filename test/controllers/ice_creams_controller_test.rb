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

  describe "create" do

    it "should create ice_cream and flash success for valid forms" do
      assert_difference("IceCream.count") do
        post ice_creams_url, params: { ice_cream: { base_flavor: @ice_cream.base_flavor, brand: @ice_cream.brand, category: @ice_cream.category, description: @ice_cream.description, name: @ice_cream.name } }
      end

      must_redirect_to ice_cream_url(IceCream.last)
      assert_equal "Successfully added new Ice Cream: <a href=\"/ice_creams/#{@ice_cream.id}\">#{@ice_cream.name}</a>", flash[:success]
    end

    it "should not create duplicated ice_cream, and flash danger" do
      duplicated_ice_cream = IceCream.last
      assert_no_difference("IceCream.count") do
        post ice_creams_url, params: { ice_cream: { base_flavor: @duplicated_ice_cream.base_flavor, brand: @duplicated_ice_cream.brand, category: @duplicated_ice_cream.category, description: @duplicated_ice_cream.description, name: @duplicated_ice_cream.name }}
      end

      must_redirect_to new_ice_cream_url
      assert_equal "Ice cream already exists, please add a new one.", flash[:danger]
    end

    it "should redirect to new form and flash danger for ice creams with no name" do
      let(:yucky_ice_cream) {
        ice_cream: {
          name: nil,
          category: "scoop",
          brand: "How The Grinch Makes Ice Cream",
          base_flavor: "mushrooms",
          description: "you're a weird one, mister grinch"
        }
      }
      assert_no_difference "IceCream.count" do
        post ice_creams_url, params: { :yucky_ice_cream }
      end
      must_redirect_to new_ice_cream_url
      assert_equal "Please fill in missing ice cream name", flash[:danger]
    end
  end

  it "should show ice_cream" do
    get ice_cream_url(@ice_cream)
    must_respond_with :success
  end

  it "should get edit" do
    get edit_ice_cream_url(@ice_cream)
    must_respond_with :success
  end

  describe "update" do
    it "should update ice_cream when given valid params" do
      patch ice_cream_url(@ice_cream), params: { ice_cream: { base_flavor: @ice_cream.base_flavor, brand: @ice_cream.brand, category: @ice_cream.category, description: @ice_cream.description, name: @ice_cream.name } }
      must_redirect_to ice_cream_url(ice_cream)
      assert_equal "<a href=\"/ice_creams/#{@ice_cream.id}\"> successfully updated.", flash[:success]
    end

    it "should not update ice_cream when given invalid params" do
      assert_no_difference (@ice_cream)
        patch ice_cream_url(@ice_cream), params: { ice_cream: { base_flavor: @ice_cream.base_flavor, brand: @ice_cream.brand, category: @ice_cream.category, description: @ice_cream.description, name: nil } }
      end
      must_redirect_to edit_ice_cream_url
      assert_equal "Could not edit <a href=\"/ice_creams/#{@ice_cream.id}\">, missing name."
    end
  end

  it "should destroy ice_cream" do
    assert_difference("IceCream.count", -1) do
      delete ice_cream_url(@ice_cream)
    end

    must_redirect_to ice_creams_url
    assert_equal "Successfully deleted ice cream."
  end
end
