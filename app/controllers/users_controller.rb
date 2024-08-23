class UsersController < ApplicationController
  def index
    @users = User.active
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def mypage
    @user = User.find(current_user.id)
    @posts = @user.posts
  end

  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.valid?(user_params)
     if @user.update(user_params)
      redirect_to mypage_path
     else
      @error_messages = @user.errors.full_messages
      redirect_to mypage_edit_path
     end
    else
     redirect_to mypage_edit_path
    end
  end
  
  def confirm
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    redirect_to new_user_registration_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :is_active)
  end
end
