require "test_helper"

describe IceCream do
  describe "validations" do
    before do 
      user = users(:picchu)
      @ice_cream = IceCream.new(name: "Salted Caramel Truffle", category: "scoop", brand: "Haagen Dazs", base_flavor: "caramel", description: "salted caramel base with caramel swirls and the cutest tiny truffles")

    end
    it "is valid when category and name are present" do
      expect(@ice_cream.valid?).must_equal true
    end

    it "is invalid when there is no ice cream name" do
      @ice_cream.name = nil
      expect(@ice_cream.valid?).must_equal false
      expect(@ice_cream.errors.messages).must_include :name
    end

    it "is invalid when category and ice cream name are non-unique" do
      unique_ice_cream = IceCream.create!(name: "Picchu's Kibbles n Carrots", category: "scoop", brand: "Picchu", base_flavor: "kibble", description: "it tastes like frozen kibbles")
      @ice_cream.name = IceCream.last.name
      expect(@ice_cream.valid?).must_equal false
      expect(@ice_cream.errors.messages).must_include :name
    end

    it "is valid when ice cream name is non-unique but category differs" do
      same_name_ice_cream = IceCream.create!(name: @ice_cream.name, category: "shape", brand: @ice_cream.brand, base_flavor: @ice_cream.base_flavor, description: @ice_cream.description)
      expect(same_name_ice_cream.name).must_equal @ice_cream.name
      expect(same_name_ice_cream.category).wont_equal @ice_cream.category
      expect(same_name_ice_cream.valid?).must_equal true
    end
  end

  describe "custom methods" do
    it "retrieves all records matching a given category filter" do
      category = "scoop" 
      result = IceCream.by_category(category)
      expect(result.length).must_equal 1
      expect(result.first.category).must_equal category
    end
  end

  describe "relations" do
    before do
      @ice_cream = ice_creams(:spumoni)
      @user = users(:picchu)
      vote = Vote.create(ice_cream_id: @ice_cream.id, user_id: @user.id, value: 1)
    end

    it "has/responds to votes" do 
      expect(@ice_cream.respond_to?(:votes)).must_equal true
      expect(@ice_cream.votes.count).must_equal 1
    end

    it "has/responds to users through votes" do
      expect(@ice_cream.respond_to?(:users)).must_equal true
      expect(@ice_cream.users.count).must_equal 1
      Vote.create(ice_cream_id: @ice_cream.id, user_id: @user.id, value: 1)
      expect(@ice_cream.users.count).must_equal 2
    end
  end
end
