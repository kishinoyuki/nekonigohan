class Public::ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @search_genre = params[:search]
  if @search_genre.blank?
   @items = Item.all
  else
   @items = Item.where(genre_id: @search_genre)
  end
 end

 def show
  @item = Item.find(params[:id])
  @posts = @item.posts
 end
 
private
def redirect_unless_current_user
 unless current_user
  redirect_to root_path
 end
end

end

