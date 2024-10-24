class Admin::TagsearchesController < ApplicationController
 layout 'admin'
 def search
  @model = Post
  @word = params[:word]
   if params[:word].blank?
    flash[:tag_alert] = "タグを入力してください"
    redirect_to admin_posts_path
   else
    @posts = Post.where("tag LIKE?","%#{@word}%").page(params[:page]).per(4)
    render "admin/tagsearches/tagsearch"
   end
 end
    
    

end
