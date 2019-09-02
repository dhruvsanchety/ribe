class UsersController < ApplicationController
  before_action :authenticate_user!
  # GET to /users/:id
  def show
    if current_user.profile
      current_user.profile.update_attribute(:search, '')
    end
    @user = User.find( params[:id] )
  end
end
