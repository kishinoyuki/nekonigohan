class Admin::UsersController < ApplicationController
 layout 'admin'
 before_action :authenticate_admin!
 
  def index
   @users = User.all
  end
  
  def show
   @user = User.find(params[:id])
  end
  
  def withdraw
   @user = User.find(params[:id])
   @user.update(is_active: false)
   flash[:success] = "退会処理が完了しました！"
   redirect_to admin_users_path
  end
end
