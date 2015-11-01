class My::ProfilesController < ApplicationController

  before_filter :restrict_access
  before_filter :current_user

  def show
    @user = current_user
  end
end