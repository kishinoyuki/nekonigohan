# frozen_string_literal: true

class Public::Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]
  before_action :check_admin_login, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:success] = "ゲストユーザーでログインしました！"
    redirect_to mypage_path
  end

  protected
    def reject_user
      @user = User.find_by(email: params[:user][:email].downcase)
      if @user
        if params[:user][:password].blank?
          flash[:alert] = "パスワードが入力されていません。"
          redirect_to new_user_registration_path
        end

        if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
          flash[:alert] = "退会済みです。再度ご登録をしてご利用ください。"
          redirect_to new_user_registration_path
        end
      else
        flash[:alert] = "該当するユーザーが見つかりません。"
      end
    end

    def check_admin_login
      if current_admin
        sign_out :user if user_signed_in?
        flash[:alert] = "管理者がログイン中です。利用者はログインできません。"
        redirect_to new_user_session_path
      end
    end
end
# GET /resource/sign_in
# def new
# super
# end

# POST /resource/sign_in
# def create
# super
# end

# DELETE /resource/sign_out
# def destroy
#   super
# end

# protected

# If you have extra params to permit, append them to the sanitizer.
# def configure_sign_in_params
#   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
# end
