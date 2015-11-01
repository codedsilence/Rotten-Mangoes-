class ProfilesController < ApplicationController
 before_filter :restrict_access
  
  def index
    @profiles = User.all
  end

  def show
    @profile = User.find(params[:id])
  end	
end
