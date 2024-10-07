class Public::PostsController < ApplicationController
    
  before_action :ensure_guest_user, only: [:new, :edit]
    
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if DonationDestination.where(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location]).exists?
     @donation_destination = DonationDestination.find_by(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
    else
     @donation_destination = DonationDestination.new(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
    end
    all_validation = []
    all_validation << @donation_destination.valid?
    
    if Item.where(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id]).exists?
     @item = Item.find_by(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id])
    else
     @item = Item.new(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id])
    end
    @item.donation_destination = @donation_destination
    all_validation << @item.valid?

    @post.item_id = @item.id
    all_validation << @post.valid?

    if all_validation == [true, true, true]
      @post.save && @item.save && @donation_destination.save
      flash[:success] = "投稿が完了しました！"
     redirect_to post_path(@post)
    else
     @all_validation = false
     render :new
    end
  end
  
  def index
    @search = params[:search]
    if @search.blank?
     @posts = Post.page(params[:page]).per(4)
    else
     @posts = Post.where(review: @search).page(params[:page]).per(4)
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
        
    unless @post.user.id == current_user.id
     flash[:alert] = "他のユーザの投稿は編集できません"
     redirect_to posts_path
    end

    @item = @post.item
    @donation_destination = @item.donation_destination
  end
  
 def update
  @post = Post.find(params[:id])
  @post.title = post_params[:title]
  @post.body = post_params[:body]
  @post.review = post_params[:review]
  all_validation = []
  all_validation << @post.valid?
  
  @item = @post.item
  @item.name = params[:post][:item_name]
  @item.genre_id = params[:post][:item_genre_id]
  all_validation << @item.valid?
  
  @donation_destination = @item.donation_destination
  @donation_destination.name = params[:post][:donation_destination_name]
  @donation_destination.location = params[:post][:donation_destination_location]
  all_validation << @donation_destination.valid?
  
  if all_validation == [true, true, true]
   @post.update(post_params) && @item.update(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id]) && @donation_destination.update(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
   flash[:success] = "編集内容が保存されました！"
   redirect_to post_path(@post)
  else
   @all_validation = false
   render :edit
  end
 end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました！"
    redirect_to mypage_path
  end
  
  private
   def post_params
     params.require(:post).permit(:title, :body, :review, :star, :image)
   end
   
   def ensure_guest_user
    if current_user.email == "guest@example.com"
     flash[:alert] = "ゲストユーザーは新規投稿、投稿の編集を行う事はできません"
     redirect_to mypage_path
    end
   end
end