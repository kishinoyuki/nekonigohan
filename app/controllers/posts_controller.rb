class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    donation_destination = DonationDestination.new(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
    donation_destination.save

    item = Item.new(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], image: params[:post][:image])
    item.donation_destination = donation_destination
    item.save
    
    @post.item_id = item.id
    @post.item = item
    
    if @post.valid?
     @post.save
     redirect_to posts_path
    else
     @error_messages = @post.errors.full_messages
      render :new
    end
  end
  
  def index
    @posts = Post.all
    
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :body, :review)
  end
end
