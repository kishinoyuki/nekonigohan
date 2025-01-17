class ApplicationController < ActionController::Base
  before_action :configure_authentication
  before_action :authenticate_user!, except: [:top], unless: :admin_controller?
  before_action :check_admin_page_access, if: :admin_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private
    def configure_authentication
      if admin_controller?
        authenticate_admin!
      else
        authenticate_user! unless action_is_public?
      end
    end

    def admin_controller?
      self.class.module_parent_name == "Admin"
    end

    def action_is_public?
      controller_name == "homes" && action_name == "top"
    end

    def check_admin_page_access
      if current_user.present? && !current_admin.present?
        flash[:alert] = "アクセスできません"
        redirect_to root_path
      end
    end

  protected
    def configure_permitted_parameters
      # if params.present? && params[:user].present?
      # reject_user(params[:user][:email], params[:user][:password])
      # end
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

  # def reject_user(email, password)
  # @user = User.find_by(email: email)
  # puts @user.inspect

  # if !(@user.active_for_authentication?)
  # flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
  # redirect_to new_user_registration_path
  # return
  # end
  # end
end
