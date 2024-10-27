Rails.application.routes.draw do

 devise_for :users, controllers: {
  sessions: 'public/users/sessions'
 }
 
#devise_for :customers, controllers: {
  #registrations: "public/registrations",
  #sessions: 'public/sessions'
#}
scope module: :public do
 resources :items, only: [:show, :index]
 resources :posts do
  resource :favorite, only: [:create, :destroy]
  resources :post_comments, only: [:create, :edit, :update, :destroy]
 end
 patch '/post/:id/private' => 'posts#toggle_status', as: 'post_private'
 get '/mypage' => 'users#mypage', as: 'mypage'
 get '/users/:id/favorite_index' => 'users#favorite_index', as: 'favorite_index'

 
 devise_scope :user do
  post "user/guest/sign_in", to: "users/sessions#guest_sign_in"
 end

 resources :users, only: [:index, :show, :edit, :update]
 get '/users/:id/confirm' => 'users#confirm', as: 'users_confirm'
 patch 'users/:id/withdraw' => 'users#withdraw', as: 'users_withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
 root to: 'homes#top'
 get 'search' => 'searches#search'
 get 'tagsearches/search' => 'tagsearches#search'
 
end

 

 
 devise_for :admin, skip: [:registrations, :password], controllers: {
  sessions: 'admin/sessions'
 }

 namespace :admin do
  resources :users, only: [:index, :show] do
   member do
    patch :withdraw
   end
  end
   
  resources :posts, only: [:index, :show, :destroy] do
   resources :post_comments, only: [:destroy]
  end
  
  resources :post_comments, only: [:index]
 delete 'post_comments/:id' => 'post_comments#destroy_from_index', as: 'destroy_from_index'
 
 get 'search' => 'searches#search', as: 'search'
 get 'tagsearches/search' => 'tagsearches#search', as: 'tagsearch'
 
end 
end

