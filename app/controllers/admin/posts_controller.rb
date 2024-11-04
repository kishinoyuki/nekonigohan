class Admin::PostsController < ApplicationController
 layout 'admin'

  def index
   @min_price = params[:min_price]
   @max_price = params[:max_price]
   @order = params[:order]
   
   if @min_price.present? && @max_price.present?
    if @order.present?
     @posts = Post.combined_price_range_and_order(@min_price, @max_price, @order)
    else
     @posts = Post.price_range(@min_price, @max_price)
    end
   else
    if @order.present?
     @posts = Post.posts_by_params_order(@order)
    else
     @posts = Post.all
    end
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
