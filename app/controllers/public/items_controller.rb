class Public::ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @min_price = params[:min_price]
  @max_price = params[:max_price]
  @search = params[:search]
  @order = params[:order]
  
  if @min_price.present? && @max_price.present?
   if @search.present? && @order.present?
    @items = Item.combined_items_genre_search_and_price_range_and_order(@search, @min_price, @max_price, @order)
   elsif @search.present? && @order.blank?
    @items = Item.combined_items_genre_search_and_price_range(@search, @min_price, @max_price)
   elsif @search.blank? && @order.present?
    @items = Item.combined_items_price_range_and_order(@min_price, @max_price, @order)
   else
    @items = Item.price_range(@min_price, @max_price)
   end
  else
   if @search.present? && @order.present?
    @items = Item.combined_items_genre_search_and_order(@search, @order)
   elsif @search.present? && @order.blank?
    @items = Item.items_by_genre_search(@search)
   elsif @search.blank? && @order.present?
    @items = Item.items_by_params_order(@order)
   else
    @items = Item.all
   end
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

