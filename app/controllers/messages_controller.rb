class MessagesController < ApplicationController
    before_action :authenticate_user!
                
                
    def create
        @chatroom = Chatroom.find(params[:chatroom_id])
        message = @chatroom.messages.new(message_params)
        message.user = current_user
        message.save
        @chatroom.chatroom_users.each do |x|
            if x.user_id != current_user.id
                x.update_attribute(:read, false)
            end
        end
        redirect_to @chatroom   
    end
    
    private
    
        def message_params
            params.require(:message).permit(:body)
        end
end
            
        
            