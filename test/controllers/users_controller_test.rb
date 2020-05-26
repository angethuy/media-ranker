require "test_helper"

describe UsersController do
  let(:user) { users(:tayti) }

  it "should get index" do
    get users_url
    must_respond_with :success
  end

  it "should show user" do
    get user_url(user.id)
    must_respond_with :success
  end

  it "should create new user" do 
    post user_url
  end

  describe "login form" do
    let(:ref_path){ "/i_like_ice_cream" } #simulate login from arbitrary page

    it "gets the login form" do
      get login_url, params: { headers: { "HTTP_REFERER": ref_path} } 
      must_respond_with :success
    end

    it "sets referer path (return_to) in session" do
      get login_url, params: { headers: { "HTTP_REFERER": ref_path} }
      expect(session[:return_to]).wont_be_empty 
      expect(session[:return_to]).must_equal "/i_like_ice_cream"
    end

  end

  # describe "login" do
  #   let(:ref_path){ "/i_like_ice_cream" }

  #   it "sets existing user to session and redirects to referer" do
  #     post login_url, params: { username: user.name }
  #     must_redirect_to ref_path
  #     assert_equal "Successfully logged in.", flash[:success]
  #     expect(session[:username]).must_equal user.name

  #   end

  #   it "creates a new user if none is found" do
  #     new_username = "shiny brand new user"
  #     assert_difference("User.count") do
  #       post login_url, params: { username: new_username }
  #     end
  #   end

  #   it "sets the new user to session and redirects to referer" do
  #     new_username = "Big Bird"
  #     post login_url, params: { username: new_username }
  #     expect(session[:username]).must_equal new_username
  #     must_redirect_to ref_path
  #   end
  # end
end
