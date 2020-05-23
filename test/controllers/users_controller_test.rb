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

  it "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: user.name } }
    end

    must_redirect_to user_url(User.last)
  end

  it "should show user" do
    get user_url(user.id)
    must_respond_with :success
  end
end
