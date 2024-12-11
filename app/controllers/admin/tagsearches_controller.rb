class Admin::TagsearchesController < ApplicationController
  layout "admin"
  def search
    @model = Post
    @word = params[:word]
    if params[:word].blank?
      flash[:tag_alert] = "タグを入力してください"
      redirect_to decide_redirect_path
    else
      @posts = Post.where("tag LIKE?", "%#{@word}%").page(params[:page]).per(4)
      render "admin/tagsearches/search"
    end
  end

 private
   def decide_redirect_path
     referer = request.referer
     referer
   end
end
