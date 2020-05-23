require "test_helper"

describe User do
  before do
    @user = users(:picchu)
  end

  describe "validations" do
    it "is valid when user has a name" do
      expect(@user.valid?).must_equal true
    end

    it "is invalid when user name is empty string" do
      @user.name = ""
      expect(@user.valid?).must_equal false
    end

    it "is invalid when user name is nil" do
      @user.name = nil
      expect(@user.valid?).must_equal false
    end
  end

  describe "relationships" do
    it "has votes" do
      expect(@user.respond_to?(:votes)).must_equal true
    end

    it "has ice creams through votes" do
      expect(@user.respond_to?(:ice_creams)).must_equal true
    end
  end
end
