class Public::RelationshipsController < ApplicationController
    before_action :ensure_guest_user
    
    def create
        user = User.find(params[:user_id])
        current_user.follow(user)
        flash[:success] = "#{user.name}さんをフォローしました！"
        redirect_to request.referer
    end
    
    def destroy
        current_user.unfollow(params[:user_id])
        redirect_to request.referer
    end
    
    private
    
     def ensure_guest_user
      if current_user.email == "guest@example.com"
       redirect_to mypage_path
      end
     end
    
end
