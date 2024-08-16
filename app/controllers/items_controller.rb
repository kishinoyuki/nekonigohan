class ItemsController < ApplicationController
 
 def show
  @item = Item.find(params[:id])
 end
 
 def edit
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

