class Public::TagsearchesController < ApplicationController
    def search
     @model = Post
     @word = params[:word]
     if params[:word].blank?
      flash[:tag_alert] = "タグを入力してください"
      redirect_to posts_path
     else
      @posts = Post.where("tag LIKE?","%#{@word}%").page(params[:page]).per(4)
      render "tagsearches/tagsearch"
     end
    end
    
    
end