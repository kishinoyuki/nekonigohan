class Public::SearchesController < ApplicationController
 before_action :authenticate_user!
 
 def search
  @range = params[:range]
  if params[:search].present? && params[:word].present?
   if @range == "User"
    @users = User.looks(params[:search], params[:word])
   elsif @range == "Item"
    @items = Item.looks(params[:search], params[:word])
   else 
    @donation_destinations = DonationDestination.looks(params[:search], params[:word])
   end
  else
   flash[:search_alert] = "検索ワードを入力してください"
   redirect_to decide_redirect_path
  end
 end
  
  private

  def decide_redirect_path
   referer = request.referer
    return referer
  end
end
