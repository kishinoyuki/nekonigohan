class Public::TagsearchesController < ApplicationController
    def search
     @model = Post
     @word = params[:word]
     @posts = Post.where("tag LIKE?","%#{@word}%").page(params[:page]).per(4)
     render "tagsearches/tagsearch"
     if @posts.nil?
      flash[:natice] = "該当するタグが見つかりません"
     end
    end
end