class Public::ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @search = params[:search]
  if @search.blank?
   @items = Item.page(params[:page]).per(10)
  else
   @items = Item.where(genre_id: @search).page(params[:page]).per(10)
  end
 end

 def show
  @item = Item.find(params[:id])
  @posts = @item.posts.page(params[:page]).per(4)
 end
 
private
def redirect_unless_current_user
 unless current_user
  redirect_to root_path
 end
end

end

