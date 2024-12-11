class Admin::UsersController < ApplicationController
  layout "admin"

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.custom_order_scope("posts.created_at", "DESC").page(params[:page]).per(4)
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    flash[:success] = "退会処理が完了しました！"
    redirect_to admin_users_path
  end
end
