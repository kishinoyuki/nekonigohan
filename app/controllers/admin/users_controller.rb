class Admin::UsersController < ApplicationController
 layout 'admin'
 before_action :authenticate_admin!
 
  def index
   @users = User.all
  end
  
  def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash[:success] = "ユーザを削除しました！"
   redirect_to admin_users_path
  end
end
