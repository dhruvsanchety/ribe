class PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create
    @user = User.find( params[:user_id] )
    @post = @user.posts.build( post_params )
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
       render action: new
    end
  end
  
  def edit
    @user = User.find( params[:user_id] )
    @post=@user.post
  end
  
  def destroy
    @post = Post.find(params[:user_id]) 
    @post.destroy
    redirect_to user_path(id:current_user.id)
  end
  
  def show 
    @search = Post.search do
      fulltext params[:search]
    end
    @posts = @search.results
  end
  
  
  private
    def post_params
       params.require(:post).permit(:title, :details, :search)
    end
end
