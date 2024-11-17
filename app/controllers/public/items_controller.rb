class Public::ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @min_price = params[:min_price]
  @max_price = params[:max_price]
  @search = params[:search]
  @order = params[:order]
  
  if @search.present? || @min_price.present? && @max_price.present? || @order.present?
   @items = Item.combined_items_genre_search_and_price_range_and_order(@search, @min_price, @max_price, @order)
  else
   @items = Item.all
  end
 
  @items = Kaminari.paginate_array(@items).page(params[:page]).per(10)

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