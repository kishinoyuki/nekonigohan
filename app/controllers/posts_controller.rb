class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    @donation_destination = DonationDestination.new(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
    all_validation = []
    all_validation << @donation_destination.valid?

    @item = Item.find_or_create_by(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], image: params[:post][:item_image])
    @item.donation_destination = @donation_destination
    all_validation << @item.valid?
    
    # find_or_crete
    @post.item_id = @item.id
    all_validation << @post.valid?

    if all_validation == [true, true, true]
      @post.save && @item.save && @donation_destination.save
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
  all_validation = []
  all_validation << @post.valid?
  
  @item = @post.item
  all_validation << @item.valid?
  
  @donation_destination = @item.donation_destination
  all_validation << @donation_destination.valid?
  
  if all_validation == [true, true, true]
   @post.update(post_params) && @item.update(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id]) &&@donation_destination.update(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
   redirect_to mypage_path
  else
   @post.errors.add(:base, "入力内容にエラーがあります")
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