class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    @donation_destination = DonationDestination.new(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
    @donation_destination.save

    @item = Item.new(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], image: params[:post][:item_image])
    @item.donation_destination = @donation_destination
    @item.save
    
    @post.item_id = @item.id

    if @post.save && @item.save && @donation_destination.save
     redirect_to posts_path
    else
     render :new
    end
  end
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @item = @post.item
    @donation_destination = @item.donation_destination
  end
  
 def update
  @post = Post.find(params[:id])
  @item = @post.item
  @donation_destination = @post.item.donation_destination
  @donation_destination.update(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
  @item.update(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], image: params[:post][:item_image])
  
  if @post.update(post_params)
     redirect_to mypage_path
  else
     render :edit
  end
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