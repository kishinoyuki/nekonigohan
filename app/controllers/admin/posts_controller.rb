class Admin::PostsController < ApplicationController
 layout 'admin'

  def index
   @search = params[:search]
   @order = params[:order]
   
   if @search.present? && @order.present?
    @posts = Post.combined_posts_search_and_order(@search, @order)
   elsif @search.present? && @order.blank?
    @posts = Post.posts_by_price_pulldown_search(@search)
   elsif @search.blank? && @order.present?
    @posts = Post.posts_by_params_order(@order)
   else
    @posts = Post.all
   end
   
   @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
   
  end
  
  def show
   @post = Post.find(params[:id])
   @post_comments = @post.post_comments.page(params[:page]).per(10)
  end
  
  def destroy
   @post = Post.find(params[:id])
   @post.destroy
   flash[:success] = "投稿を削除しました！"
   redirect_to admin_posts_path
  end
end
