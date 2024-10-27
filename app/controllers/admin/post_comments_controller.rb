class Admin::PostCommentsController < ApplicationController
 layout 'admin'
 before_action :authenticate_admin!, only: [:destroy]
 
 def index
  @post_comments = PostComment.page(params[:page]).per(10)
 end
 
 def destroy_from_index
  post_comment = PostComment.find(params[:id])
  post_comment.destroy
  flash[:success] = "コメントを削除しました！"
  redirect_to admin_post_comments_path
 end
  
 
 def destroy
  PostComment.find(params[:id]).destroy
  flash[:success] = "コメントを削除しました！"
  redirect_to admin_post_path(params[:post_id])
 end
end
