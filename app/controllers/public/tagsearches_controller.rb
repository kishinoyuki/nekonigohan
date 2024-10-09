class Public::TagsearchesController < ApplicationController
    def search
     @model = Item
     @word = params[:content]
     if params[:content].present?
      @items = Item.where("category LIKE?","%#{@word}%")
      render "tagsearches/tagsearch"
     else
      flash[:tag_alert] = "タグを入力してください"
      redirect_to decide_redirect_path
     end
    end
    
    private
    
    def decide_redirect_path
     referer = request.referer
      return referer
    end
end
