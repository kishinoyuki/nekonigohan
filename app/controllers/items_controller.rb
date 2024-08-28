class ItemsController < ApplicationController
 
 def index
  @items = Item.all
 end

 def show
  @item = Item.find(params[:id])
  @posts = @item.posts
 end
 

end

