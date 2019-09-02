class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    if current_user.profile
      current_user.profile.update_attribute(:search, '')
      current_user.profile.update_attribute(:genderpreference, 'Does Not Matter')
      current_user.profile.update_attribute(:minimumage, 13)
      current_user.profile.update_attribute(:maximumage, 100)
      stored_location_for(resource) || root_path
    else
      new_user_profile_path(user_id: current_user.id)
    end
	  
  end
end