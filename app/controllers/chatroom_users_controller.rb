class ChatroomUsersController < ApplicationController


	def create
		@chatroom = Chatroom.find(params[:chatroom_id])
		@request = Request.find(params[:request_id])
		@chatroom_user = @chatroom.chatroom_users.where(user_id: @request.user_id).first_or_create
		@chatroom.requests.where(user_id: @request.user_id).destroy_all
		redirect_to chatrooms_path(user_id: current_user.id)
	end 
	

	
	def show
		@chatroom = Chatroom.find(params[:chatroom_id])
		@chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
		@chatroom_user.update_attribute(:admin, true)
	
		redirect_to @chatroom
		
		
	end 
	
	def destroy
		@chatroom = Chatroom.find(params[:chatroom_id])
		@chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first
		@chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
		if @chatroom_user.admin == true
			@chatroom.chatroom_users.each do |x|
				x.update_attribute(:admin, true)
			end
		end
		redirect_to chatrooms_path(user_id: current_user.id)
	end
	

	



end