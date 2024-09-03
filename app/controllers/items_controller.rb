class ItemsController < ApplicationController
 
 before_action :redirect_unless_current_user
 
 def index
  @items = Item.all
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

