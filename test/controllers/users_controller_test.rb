require "test_helper"

describe UsersController do
  let(:user) { users(:tayti) }
  let(:ref_path) { "/i_love_ice_cream" } # simulate hitting logging in/out from arbitrary referer

  it "should get index" do
    get users_url
    must_respond_with :success
  end

  it "should show user" do
    get user_url(user.id)
    must_respond_with :success
  end

  it "should create new user" do 
    new_name = "Finne"
    assert_difference("User.count") do
      post users_url, params: { user: { name: new_name } }
    end
    expect(User.last.name).must_equal new_name
  end

  describe "login form" do

    it "gets the login form" do
      get login_url, headers: { HTTP_REFERER: ref_path }
      must_respond_with :success
    end

    it "sets referer path (return_to) in session" do
      get login_url, headers: { HTTP_REFERER: ref_path }
      expect(session[:return_to]).must_equal ref_path
    end

  end

  describe "login" do

    before do
      get login_url, headers: { HTTP_REFERER: ref_path } 
    end

    it "sets existing user to session and redirects to referer" do
      post login_url, params: { username: user.name }
      must_redirect_to ref_path
      assert_equal "Welcome back #{user.name}! Successfully logged in with ID: #{user.id}.", flash[:success]
      expect(session[:user_id]).must_equal user.id
    end


    it "creates a new user if none is found" do
      new_username = "shiny brand new user"
      assert_difference("User.count") do
        post login_url, params: { username: new_username }
      end
    end

    it "sets the new user to session and redirects to referer with success flash" do
      new_username = "Big Bird"
      post login_url, params: { username: new_username }
      expect(session[:user_id]).must_equal User.last.id
      must_redirect_to ref_path
      assert_equal "Logged in as new user #{new_username} with ID: #{User.last.id}.", flash[:success]
    end
  end

  describe "logout" do

    describe "while not logged in" do

      it "gives error message when trying to log out" do
        post logout_url, headers: { HTTP_REFERER: ref_path }
        must_redirect_to root_path
        assert_equal "Error: no user is currently logged in.", flash[:danger]
      end

    end

    describe "while logged in" do

      before do
        get login_url, headers: { HTTP_REFERER: ref_path } 
        post login_url, params: { username: user.name }
      end

      it "clears session and redirects with success when user is logged in" do
        post logout_url, headers: { HTTP_REFERER: ref_path }
        expect(session[:user_id]).must_be_nil
        must_redirect_to root_path
        assert_equal "Successfully logged out, bye bye #{user.name}", flash[:success]
      end
    end

  end
end

