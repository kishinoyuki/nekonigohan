class ItemsController < ApplicationController
 
 def new
  @item = Item.new
 end
 
 def create
  @item = Item.new(item_params)
  @item.save
  redirect_to posts_path
 end
 
 def show
  @item = Item.find(params[:id])
 end
 
 def update
  @item = Item.find(params[:id])
  @item.update(item_params)
  redirect_to posts_path
 end
 
 def destroy
  @item = Item.find(params[:id])
  @item.destroy
  redirect_to posts_path
 end
 
 private
 def item_params
  params.require(:item).permit(:name)
 end#
end

