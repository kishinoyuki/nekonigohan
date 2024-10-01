class Public::FavoritesController < ApplicationController
 def create
  post = Post.find(params[:post_id])
  favorite = current_user.favorites.new(post_id: post.id)
  favorite.save
  flash[:success] = "投稿をブックマークしました！"
  redirect_to decide_redirect_path
 end
 
 def destroy
  post = Post.find(params[:post_id])
  favorite = current_user.favorites.find_by(post_id: post.id)
  favorite.destroy
  redirect_to decide_redirect_path
 end
 
 private
 
 def decide_redirect_path
  referer = request.referer
   return referer
 end
end
