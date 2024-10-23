class Admin::PostsController < ApplicationController
 layout 'admin'

  def index
   @posts = Post.page(params[:page]).per(4)
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
