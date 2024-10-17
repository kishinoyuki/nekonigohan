class Public::ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @search = params[:search]
  @order = params[:order]
  
  if @search.present? && @order.present?
   @items = combined_items_search_and_order
  elsif @search.present? && @order.blank?
   @items = items_by_pulldown_search
  elsif @search.blank? && @order.present?
   @items = items_by_params_order
  else
   @items = Item.all
  end 
  
  @items = @items.page(params[:page]).per(10)
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

def items_by_pulldown_search
 case params[:search]
 when "~1000円"
  Item.where(price: ..1000)
 when "1000~3000円"
  Item.where(price: 1000..3000)
 when "3000~5000円"
  Item.where(price: 3000..5000)
 when "5000~10000円"
  Item.where(price: 5000..10000)
 when "10000円~"
  Item.where(price: ..10000)
 when "食品"
  Item.where(genre_id: 1)
 when "化粧品"
  Item.where(genre_id: 2)
 when "キッチン用品"
  Item.where(genre_id: 3)
 when "インテリア"
  Item.where(genre_id: 4)
 when "日用雑貨"
  Item.where(genre_id: 5)
 when "ペット用品"
  Item.where(genre_id: 6)
 end
end

def items_by_params_order
 case params[:order]
 when "価格が安い商品から"
  Item.custom_order_scope('price', 'ASC')
 when "価格が高い商品から"
  Item.custom_order_scope('price', 'DESC')
 end
end

def combined_items_search_and_order
 items_by_pulldown_search + items_by_params_order
end

end

