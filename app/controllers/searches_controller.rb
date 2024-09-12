class SearchesController < ApplicationController
 before_action :authenticate_user!
 
 def search
  @range = params[:range]
  if @range == User
   @users = User.looks(params[:search], params[:word])
  elsif @range == Item
   @items = Item.looks(params[:search], params[:word])
  else @range = DonationDestination
   @donation_destination = DonationDestination.looks(params[:search], params[:word])
  end
 end
end
