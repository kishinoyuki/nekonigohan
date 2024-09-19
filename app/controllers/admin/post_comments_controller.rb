class Admin::PostCommentsController < ApplicationController
 layout 'admin'
 before_action :authenticate_admin!, only: [:destroy]
 
 def destroy
  PostComment.find(params[:id]).destroy
  flash[:success] = "コメントを削除しました！"
  redirect_to admin_post_path(params[:post_id])
 end
end
