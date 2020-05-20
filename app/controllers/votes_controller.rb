class VotesController < ApplicationController
  before_action :set_user, only: [:create]

  def create
  end

  private

  def set_user
    @user = session[:user[:id]]
    if @user = nil
      #redirect to the referrer with 
      #fail flash
    end
  end
end