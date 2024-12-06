class Public::PostsController < ApplicationController
 
  before_action :ensure_guest_user, only: [:new, :edit]
  before_action :ensure_private_mode, only: [:show] 
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
    
    if Item.where(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], price: params[:post][:item_price]).exists?
     @item = Item.find_by(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], price: params[:post][:item_price])
    else
     @item = Item.new(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], price: params[:post][:item_price])
    end
     all_validation << @item.valid?

     all_validation << @post.valid?
     
    if all_validation == [true, true, true]
      @donation_destination.save
      @item.donation_destination_id = @donation_destination.id
      @item.save
      @post.item_id = @item.id
      @post.save
      flash[:success] = "投稿が完了しました！"
     redirect_to post_path(@post)
    else
     @all_validation = false
     render :new
    end
  end
  
  def index
   @min_price = params[:min_price]
   @max_price = params[:max_price]
   @order = params[:order]
   
   if @min_price.present? && @max_price.present? || @order.present?
    @posts = Post.public_posts.combined_price_range_and_order(@min_price, @max_price, @order)
   else
    @posts = Post.public_posts.custom_order_scope('posts.created_at', 'DESC')
   end
   
   @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
   
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.custom_order_scope('post_comments.created_at', 'DESC').page(params[:page]).per(10)
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
  if @post.update(post_params)
   flash[:success] = "投稿を編集しました！"
   redirect_to post_path(@post)
  else
   render :edit
  end
 end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました！"
    redirect_to mypage_path
  end
  
  def toggle_status
   @post = Post.find(params[:id])
   if @post.private == false
    @post.update(private: true)
    flash[:success] = "投稿を非公開にしました！"
   else
    @post.update(private: false)
    flash[:success] = "投稿を非表示を解除しました！"
   end
   
   redirect_to mypage_path
  end

  
  private
   def post_params
     params.require(:post).permit(:title, :body, :tag, :star, :image, :private)
   end
   
   def ensure_guest_user
    if current_user.email == "guest@example.com"
     flash[:alert] = "ゲストユーザーは新規投稿、投稿の編集を行う事はできません"
     redirect_to mypage_path
    end
   end
    
   def ensure_private_mode
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id && @post.private == true
     flash[:alert] = "この投稿は表示できません"
     redirect_to posts_path
    end
   end
   
  
  
  
  
end