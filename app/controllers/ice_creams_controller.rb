class IceCreamsController < ApplicationController
  before_action :set_ice_cream, only: [:show, :edit, :update, :destroy, :vote]
  before_action :set_user, only: [:vote]
  

  # GET /ice_creams
  # GET /ice_creams.json
  def index
    @ice_creams = IceCream.all
  end

  # GET /ice_creams/1
  # GET /ice_creams/1.json
  def show
  end

  # GET /ice_creams/new
  def new
    @ice_cream = IceCream.new
  end

  # GET /ice_creams/1/edit
  def edit
  end

  # POST /ice_creams
  # POST /ice_creams.json
  def create
    @ice_cream = IceCream.new(ice_cream_params)

    respond_to do |format|
      if @ice_cream.save
        format.html { redirect_to @ice_cream, flash: { success: "Successfully added new ice cream: #{view_context.link_to @ice_cream.name, ice_cream_path(@ice_cream.id) }." } }
        format.json { render :show, status: :created, location: @ice_cream }
      else
        format.html { render :new }
        format.json { render json: @ice_cream.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ice_creams/1
  # PATCH/PUT /ice_creams/1.json
  def update
    respond_to do |format|
      if @ice_cream.update(ice_cream_params)
        format.html { redirect_to @ice_cream, notice: 'Ice cream was successfully updated.' }
        format.json { render :show, status: :ok, location: @ice_cream }
      else
        format.html { render :edit }
        format.json { render json: @ice_cream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ice_creams/1
  # DELETE /ice_creams/1.json
  def destroy
    @ice_cream.destroy
    respond_to do |format|
      format.html { redirect_to ice_creams_url, flash: { success: "Successfully deleted #{@ice_cream.name}."} }
      format.json { head :no_content }
    end
  end

  def vote 

    if @ice_cream.votes.find_by(user_id: @user.id) #user has already voted for this
      redirect_back(fallback_location: root_path, flash: { danger: "#{@user.name} already upvoted #{@ice_cream.name}"})
      return
    end

    vote_data = {
      ice_cream_id: @ice_cream.id,
      user_id: @user.id,
      value: 1
    }

    vote = Vote.create(vote_data)
    result = vote.save ? { success: "Successfully voted for #{@ice_cream.name}." } : { danger: "Voting failed." }
    redirect_back(fallback_location: root_path, flash: result)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ice_cream
      @ice_cream = IceCream.find(params[:id])
    end

    def set_user 
      # @user = User.find_by(id: 1)
      if session[:user_id]
        @user = User.find_by(id: session[:user_id])
      else 
        redirect_back(fallback_location: root_path)
        flash[:danger] = "Not logged in."
      end
    end

    # Only allow a list of trusted parameters through.
    def ice_cream_params
      params.require(:ice_cream).permit(:name, :category, :brand, :base_flavor, :description)
    end
end
