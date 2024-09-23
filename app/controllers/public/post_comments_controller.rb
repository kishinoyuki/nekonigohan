class Public::PostCommentsController < ApplicationController
 
 before_action :redirect_ensure_guest_user, only: [:edit]
 
 def create
  post = Post.find(params[:post_id])
  comment = current_user.post_comments.new(post_comment_params)
  comment.post_id = post.id
  if comment.save
  flash[:success] = "コメントを投稿しました！"
  redirect_to post_path(post)
  else
  flash[:alert] = "コメントを入力して下さい。"
  redirect_to post_path(post)
  end
 end
 
 def edit
  @post = Post.find(params[:post_id])
  @post_comment = PostComment.find(params[:id])
 end
 
 def update
  @post = Post.find(params[:post_id])
  @post_comment = PostComment.find(params[:id])
  if @post_comment.update(post_comment_params)
   flash[:success] = "コメントを編集しました！"
   redirect_to post_path(params[:post_id])
  else
   flash.now[:alert] = "コメントを入力して下さい。"
   render :edit
  end
 end
  
 def destroy
  PostComment.find(params[:id]).destroy
  redirect_to post_path(params[:post_id])
 end

 private

 def post_comment_params
  params.require(:post_comment).permit(:comment)
 end
 
 def redirect_ensure_guest_user
  post = Post.find(params[:post_id])
  if current_user.email == "guest@example.com"
   flash[:alert] = "コメントを投稿する事ができません"
   redirect_to post_path(post)
  end
 end
end