Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  devise_scope :user do
    post "user/guest/sign_in", to: "users/sessions#guest_sign_in"
  end
#devise_for :customers, controllers: {
  #registrations: "public/registrations",
  #sessions: 'public/sessions'
#}
  resources :items, only: [:show, :index]
  resources :posts do
   resources :post_comments, only: [:create, :edit, :update, :destroy]
  end
  get '/mypage' => 'users#mypage', as: 'mypage'

  resources :users, only: [:index, :show, :edit, :update]
  get '/users/:id/confirm' => 'users#confirm', as: 'users_confirm'
  patch 'users/:id/withdraw' => 'users#withdraw', as: 'users_withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
  root to: 'homes#top'
  get "search" => "searches#search"
end
