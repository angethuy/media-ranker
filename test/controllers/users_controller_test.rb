require "test_helper"

describe UsersController do
  let(:user) { users(:one) }

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
      post users_url, params: { user: { name: @user.name } }
    end

    must_redirect_to user_url(User.last)
  end

  it "should show user" do
    get user_url(@user)
    must_respond_with :success
  end

  it "should get edit" do
    get edit_user_url(@user)
    must_respond_with :success
  end

  it "should update user" do
    patch user_url(@user), params: { user: { name: @user.name } }
    must_redirect_to user_url(user)
  end

  it "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    must_redirect_to users_url
  end
end
