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

  # GET /users/new
  def new
    @user = User.new
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
    user = User.find_by(name: username)
    if user #existing user found
      result = { success: "Welcome back #{user.name}! Successfully logged in."}
    else
      user = User.create(username: username)
      result = { success: "Logged in as new user #{user.name}." }
    end
    session[:user] = user
    redirect_to session.delete(:return_to), flash: result
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
