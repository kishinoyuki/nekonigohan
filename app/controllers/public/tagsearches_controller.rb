class Public::TagsearchesController < ApplicationController
    def search
     @word = params[:content]
     if params[:content].present?
      @tag = Tag.find_by(content: @word)
      if @tag.present?
       @items = @tag.items.page(params[:page]).per(10)
       render "tagsearches/tagsearch"
      else
       flash[:tag_alert] = "該当するタグが見つかりません"
       redirect_to decide_redirect_path
      end
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
