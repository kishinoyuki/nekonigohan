class Public::ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @search = params[:search]
  @order = params[:order]
  
  if @search.present? && @order.present?
   @items = Item.combined_items_search_and_order(@search, @order)
  elsif @search.present? && @order.blank?
   @items = Item.items_by_pulldown_search(@search)
  elsif @search.blank? && @order.present?
   @items = Item.items_by_params_order(@order)
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

