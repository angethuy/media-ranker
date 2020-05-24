require "test_helper"

describe UsersController do
  let(:user) { users(:tayti) }

  it "should get index" do
    get users_url
    must_respond_with :success
  end

  it "should get new" do
    get new_user_url
    must_respond_with :success
  end

  describe "create" do
    let(:ref_path){ "/i_like_ice_cream" } #simulate login from arbitrary page

    it "should create a unique user" do
      assert_difference("User.count") do
        post users_url, params: { user: { name: "Finn" } }, headers: { "HTTP_REFERER": ref_path} 
      end
      must_redirect_to ref_path
    end


    it "should not create already existing user" do
      assert_no_difference("User.count") do
        post users_url, params: { user: { name: user.name } }
      end
    end

    it "should correctly set session when a valid user is found" do
    end

  end

  it "should show user" do
    get user_url(user.id)
    must_respond_with :success
  end
end
