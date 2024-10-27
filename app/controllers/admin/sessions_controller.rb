# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
 layout 'admin'
 before_action :check_admin_session_expiry
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

   def create
    if session[:user_id].present?
     session.delete(:user_id)
    end
    super
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

   def after_sign_in_path_for(resource)
    admin_users_path# ログイン後にリダイレクトするパス
   end

   def after_sign_out_path_for(resource_or_scope)
    flash[:success] = "ログアウトしました！"
    new_admin_session_path # ログアウト後にリダイレクトするパス
   end
   
   def check_admin_session_expiry
    if session[:admin_last_visited_at].present? && Time.now - session[:last_visited_at] > 30.minutes
     session[:admin_id] = nil
     flash[:alert] = "管理者セッションがタイムアウトしました。再度ログインしてください。"
     redirect_to new_admin_session_path
    else
     session[:admin_last_visited_at] = Time.now
    end
   end
     
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
