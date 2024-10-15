class Public::ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @search = params[:search]
  @order = params[:order]
  
  if @search.present? && @order.present?
   if params[:order] == "価格が安い商品から" 
    @items = Item.where(genre_id: @search).order(price: :asc).page(params[:page]).per(10)
   elsif params[:order] == "価格が高い商品から"
    @items = Item.where(genre_id: @search).order(price: :desc).page(params[:page]).per(10)
   end
   
  elsif @search.present? && @order.blank?
   @items = Item.where(genre_id: @search).page(params[:page]).per(10)
  
  elsif @search.blank? && @order.present?
   if params[:order] == "価格が安い商品から"
    @items = Item.order(price: :asc).page(params[:page]).per(10)
   elsif params[:order] == "価格が高い商品から"
    @items = Item.order(price: :desc).page(params[:page]).per(10)
   end
   
  else
   @items = Item.page(params[:page]).per(10)
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

