class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  def after_sign_in_path_for(resource)
    mypage_path
  end
 
  def after_sign_out_path_for(resource)
    about_path
  end
 
  protected
 
  def configure_permitted_parameters

    if params.present? && params[:user].present?
      reject_user(params[:user][:email], params[:user][:password]) 
    end
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
 
  def reject_user(email, password)
    @user = User.find_by(email: email)
    
    if !(@user.active_for_authentication?)
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_user_registration_path
    elsif @user.blank?
      flash[:notice] = "該当するユーザーが見つかりません"
    else
     
    end
  end
end
