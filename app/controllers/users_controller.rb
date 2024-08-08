class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end
  

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    redirect_to new_user_registration_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :is_active)
  end
end
