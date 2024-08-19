class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    
    item = Item.new(name: params[:post][:item_name], get_image: params[:post][:item_get_image])
    item.save
    
    donation_destination = DonationDestination.new(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
    donation_destination.save
    
    genre = Genre.new(id: params[:post][:genre_id])
    genre.save
    
    
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
