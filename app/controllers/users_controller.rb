class UsersController < ApplicationController
 
 before_action :redirect_unless_current_user, except: [:index]
 
  def index
   unless current_user
    redirect_to new_user_registration_path
   else
    @users = User.active
   end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def mypage
   if session[:referrer] == 'new_user_session'
    flash[:success] = "ログインしました！"
   elsif session[:referrer] == 'user_registration'
    flash[:success] = "会員登録完了です！"
   end
   
   session.delete(:referrer)
    @user = User.find(current_user.id)
    @posts = @user.posts
  end

  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
     if @user.update(user_params)
      flash[:success] = "ユーザ編集を保存しました！"
      redirect_to mypage_path
     else
      render :edit
     end
  end
  
  def confirm
    @user = User.find(current_user.id)
  end

  def withdraw
     @user = User.find(current_user.id)
     @user.update(is_active: false)
     reset_session
     redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :is_active, :introduction, :profile_image)
  end
  
  def redirect_unless_current_user
   unless current_user
    redirect_to root_path
   end
  end
end
