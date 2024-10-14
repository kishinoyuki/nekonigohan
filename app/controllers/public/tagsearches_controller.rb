class Public::TagsearchesController < ApplicationController
    def search
     @model = Post
     @word = params[:word]
     
     @posts = Post.where("tag LIKE?","%#{@word}%").page(params[:page]).per(4)
     render "tagsearches/tagsearch"
    end
end