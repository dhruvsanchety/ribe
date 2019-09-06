class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  # GET /chatrooms
  # GET /chatrooms.json
  def index
    @user = User.find_by_uid(current_user.uid)
    if current_user.profile
      current_user.profile.update_attribute(:search, '')
    end
    @chatrooms = Chatroom.all
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    
    @user = User.find_by_uid(current_user.uid)
    if current_user.profile
      current_user.profile.update_attribute(:search, '')
    end
    @chatroom = Chatroom.find(params[:id])
    
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first
    if @chatroom_user
      @chatroom_user.update_attribute(:read, true)
      @messages = @chatroom.messages.order(created_at: :desc).reverse
    end
  end
  
  
  
  def update
    @user = User.find_by_uid(current_user.uid)
    @chatroom = Chatroom.find( params[:chatroom_id] )
    if @chatroom.update_attributes(chatroom_params)
      redirect_to user_path(id: params[:user_id] )
    end
  end

  # GET /chatrooms/new
  def new
    @user = User.find_by_uid(current_user.uid)
    if current_user.profile
      current_user.profile.update_attribute(:search, '')
    end
    @chatroom = Chatroom.new
    @chatroom.update_attribute(:city, current_user.profile.city)
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms
  # POST /chatrooms.json
  def create
    @user = User.find_by_uid(current_user.uid)
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to chatroom_chatroom_users_path(chatroom_id: @chatroom.id, user_id: current_user.id), method: :post
    else
      render action: new
    end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def chatroom_params
      params.require(:chatroom).permit(:title, :details, :search, :gender, :collegestudent, :minimumage, :maximumage, :city, :visible)
    end
    
end
