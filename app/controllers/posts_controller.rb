class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    item = Item.new(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id])
    item.save
    @post.item_id = item.id
    @post.item = item
    
    donation_destination = DonationDestination.new(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
    donation_destination.save
    @post.item.donation_destination_id = donation_destination.id
    @post.item.donation_destination = donation_destination
    
    @post.save
    
    redirect_to posts_path
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
