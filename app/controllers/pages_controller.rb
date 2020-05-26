class PagesController < ApplicationController
  
  def index
    @ice_creams = IceCream.all
  end

end
