require "test_helper"

describe Vote do

  before do
    @ice_cream = ice_creams(:classic)
    @user = users(:elvy)
    @vote = Vote.create(ice_cream_id: @ice_cream.id, user_id: @user.id, value: 1)
  end

  describe "relations" do
    it "has a user" do
      expect(@vote.respond_to?(:user)).must_equal true
      expect(@vote.user_id).must_equal @user.id
    end

    it "has an ice cream" do
      expect(@vote.respond_to?(:ice_cream)).must_equal true
      expect(@vote.ice_cream_id).must_equal @ice_cream.id
    end
  end
end
