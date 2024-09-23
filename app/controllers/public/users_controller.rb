class Public::UsersController < ApplicationController
 
 before_action :ensure_guest_user, only: [:edit]
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
    @user = User.find(current_user.id)
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
     if @user.id != current_user.id
      flash[:alert] = "他のユーザーのプロフィールは編集できません。"
      redirect_to mypage_path
     end
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
     flash[:success] = "退会処理が完了しました。またのご利用をお待ちしております。"
     redirect_to new_user_registration_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :is_active, :introduction, :profile_image)
  end
  
  def ensure_guest_user
   if current_user.email == "guest@example.com"
    redirect_to mypage_path
   end
  end
end