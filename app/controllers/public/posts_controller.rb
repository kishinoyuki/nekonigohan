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
    
    if Item.where(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id]).exists?
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
   @search = params[:search]
   @order = params[:order]

   if @search.present? && @order.present?
    @posts = Post.public_posts.combined_posts_search_and_order(@search, @order)
   elsif @search.present? && @order.blank?
    @posts = Post.public_posts.posts_by_price_pulldown_search(@search)
   elsif @search.blank? && @order.present?
    @posts = Post.public_posts.posts_by_params_order(@order)
   else
    @posts = Post.public_posts
   end
   
   @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
   
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
    if @post.tag.content.present?
     @tag = @post.tag
    end
  end
  
 def update
  @post = Post.find(params[:id])
  @post.title = post_params[:title]
  @post.body = post_params[:body]
  @post.tag = post_params[:tag]
  all_validation = []
  all_validation << @post.valid?
  
  
 if Item.where(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], price: params[:post][:item_price]).exists?
  @item = Item.find_by(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], price: params[:post][:item_price])
 else
  @item = @post.item
  @item.name = params[:post][:item_name]
  @item.genre_id = params[:post][:item_genre_id]
  all_validation << @item.valid?
 end
  
 if DonationDestination.where(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location]).exist?
  @donation_destination = DonationDestination.find_by(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location])
 else 
  @donation_destination = @item.donation_destination
  @donation_destination.name = params[:post][:donation_destination_name]
  @donation_destination.location = params[:post][:donation_destination_location]
  all_validation << @donation_destination.valid?
 end
 
  if all_validation == [true, true, true]
   @post.update(post_params) && @item.update(name: params[:post][:item_name], genre_id: params[:post][:item_genre_id], price: params[:post][:item_price]) && @donation_destination.update(name: params[:post][:donation_destination_name], location: params[:post][:donation_destination_location]) && @tag.update(content: params[:post][:tag_content])
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
  
  def toggle_status
   @post = Post.find(params[:id])
   if @post.private == false
    @post.update(private: true)
    flash[:success] = "投稿を非公開にしました！"
   else
    @post.update(private: false)
    flash[:success] = "投稿を非表示を解除しました！"
   end
   
   redirect_to post_path(@post)
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