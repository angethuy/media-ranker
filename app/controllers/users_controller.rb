class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def login_form
    session[:return_to] = request.referer
    @user = User.new
  end

  def login 
    username = params[:username]
    @user = User.find_by(name: username)
    if @user #existing user found
      redirect_to session.delete(:return_to), flash: { success: "Welcome back #{@user.name}! Successfully logged in with ID: #{@user.id}." }
    else
      @user = User.new(name: username)
      if @user.save
        session[:user_id] = @user.id
        redirect_to session.delete(:return_to), flash: { success: "Logged in as new user #{@user.name} with ID: #{@user.id}." }
      else 
        render "login_form"
      end
    end
  end

  def logout 
    logged_in = session[:user_id]

    if logged_in
      username = User.find_by(id: logged_in)
      session.delete(:user_id)
      redirect_to root_path, flash: { success: "Successfully logged out, bye bye #{username.name}" }
    else 
      redirect_to root_path, flash: { danger: "Error: no user is currently logged in." }
    end 

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name)
    end
end
