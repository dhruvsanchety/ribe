class ProfilesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :only_current_user
  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find_by_uid(current_user.uid)
    
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile Created"
      
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :new
    end
  end
  
  def edit
    @user = User.find_by_uid(current_user.uid)
    @profile=@user.profile
  end
    
  def update
    @user = User.find_by_uid(current_user.uid)
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated."
      #redirect to their profile page
      redirect_to root_path
    else
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :age, :gender, :city, :collegeemail, :minimumage, :maximumage, :genderpreference, :collegepreference, :search)
    end
    
    def only_current_user
      @user = User.find_by_uid(current_user.uid)
      redirect_to(root_url) unless @user == current_user
    end
  
end