require "test_helper"

describe IceCreamsController do

  let(:ref_path) { "/" } # simulate logging in from arbitrary referer
  let(:ice_cream) { ice_creams(:strawberry) }
  let(:user) { users(:picchu) }

  it "should get index" do
    get ice_creams_url
    must_respond_with :success
  end

  it "should show ice_cream" do
    get ice_cream_url(ice_cream)
    must_respond_with :success
  end

  it "should get new" do
    get new_ice_cream_url
    must_respond_with :success
  end

  it "should get edit" do
    get edit_ice_cream_url(ice_cream.id)
    must_respond_with :success
  end

  describe "create" do

    it "should create ice_cream and flash success for valid forms" do
      assert_difference("IceCream.count") do
        post ice_creams_url, params: { ice_cream: { base_flavor: ice_cream.base_flavor, brand: ice_cream.brand, category: ice_cream.category, description: ice_cream.description, name: ice_cream.name } }
      end

      must_redirect_to ice_cream_url(IceCream.last)
      assert_equal "Successfully added new Ice Cream: <a href=\"/ice_creams/#{ice_cream.id}\">#{ice_cream.name}</a>", flash[:success]
    end

    it "should not create duplicated ice_cream, and flash danger" do
      duplicated_ice_cream = IceCream.last
      assert_no_difference("IceCream.count") do
        post ice_creams_url, params: { ice_cream: { base_flavor: duplicated_ice_cream.base_flavor, brand: duplicated_ice_cream.brand, category: duplicated_ice_cream.category, description: duplicated_ice_cream.description, name: duplicated_ice_cream.name }}
      end

      must_redirect_to new_ice_cream_url
      assert_equal "Ice cream already exists, please add a new one.", flash[:danger]
    end

    let(:yucky_ice_cream) { 
      {
      ice_cream: {
        name: nil,
        category: "scoop",
        brand: "How The Grinch Makes Ice Cream",
        base_flavor: "mushrooms",
        description: "you're a weird one, mister grinch"
      }
    }
  }

    it "should redirect to new form and flash danger for ice creams with no name" do
      assert_no_difference("IceCream.count") do
        post ice_creams_url, params: yucky_ice_cream
      end
      must_redirect_to new_ice_cream_url
      assert_equal "Please fill in missing ice cream name", flash[:danger]
    end
  end

  describe "update" do
    it "should update ice_cream when given valid params" do
      patch ice_cream_url(ice_cream.id), params: { ice_cream: { base_flavor: ice_cream.base_flavor, brand: ice_cream.brand, category: ice_cream.category, description: ice_cream.description, name: ice_cream.name } }
      must_redirect_to ice_cream_url(ice_cream.id)
      assert_equal "<a href=\"/ice_creams/#{ice_cream.id}\"> successfully updated.", flash[:success]
    end

    it "should not update ice_cream when given invalid params" do
      assert_no_difference("IceCream.count") do
        patch ice_cream_url(ice_cream), params: { ice_cream: { base_flavor: ice_cream.base_flavor, brand: ice_cream.brand, category: ice_cream.category, description: ice_cream.description, name: nil } }
      end
      must_redirect_to edit_ice_cream_url
      assert_equal "Could not edit <a href=\"/ice_creams/#{ice_cream.id}\">, missing name.", flash[:danger]
    end
  end

  describe "vote" do
    let(:back) { "/vote_origin_path" }

    describe "voting while not logged in" do

      it "does not create vote when no one is logged in" do
        assert_no_difference("Vote.count") do
          post vote_ice_cream_url(ice_creams(:classic).id), params: { user: user }, headers: { HTTP_REFERER: back }
        end
      end

      it "redirects back with a danger flash" do
        post vote_ice_cream_url(ice_creams(:classic).id), params: { user: user }, headers: { HTTP_REFERER: back }
        must_redirect_to back
        assert_equal "Not logged in.", flash[:danger]
      end

    end

    describe "voting while logged in" do
      before do
        get login_url, headers: { HTTP_REFERER: ref_path } 
        post login_url, params: { username: user.name }
        post vote_ice_cream_url(ice_cream.id), params: {user: user}, headers: { HTTP_REFERER: back }
      end
  
      it "creates a new valid vote and redirects back with success flash" do
        assert_difference("Vote.count") do
          assert_difference("user.votes.count") do
            post vote_ice_cream_url(ice_creams(:classic).id), params: { user: user }, headers: { HTTP_REFERER: back }
          end
        end
        must_redirect_to back
        assert_equal "Successfully voted.", flash[:success]
      end
  
      it "does not create duplicate votes between users and ice creams" do
        assert_no_difference("Vote.count") do
          post vote_ice_cream_url(ice_cream.id), params: {user: user}, headers: { HTTP_REFERER: back }
        end
      end
  
      it "redirects back and flashes danger on duplicate votes" do
        post vote_ice_cream_url(ice_cream.id), params: {user: user}, headers: { HTTP_REFERER: back }
        must_redirect_to back
        assert_equal "#{user.name} already upvoted #{ice_cream.name}", flash[:danger]
      end
    end
  end

  it "should destroy ice_cream" do
    assert_difference("IceCream.count", -1) do
      delete ice_cream_url(ice_cream.id)
    end

    must_redirect_to ice_creams_url
    assert_equal "Successfully deleted #{ice_cream.name}.", flash[:success]
  end
end
