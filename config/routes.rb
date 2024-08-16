Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:show, :edit, :update]
  resources :posts, except: [:show]
  get '/mypage' => 'users#mypage'
  get '/mypage/edit' => 'users#edit'
  patch '/mypage' => 'users#update'
  resources :users, only: [:index, :show]
  get '/users/:id/confirm' => 'users#confirm', as: 'users_confirm'
  patch 'users/withdraw' => 'users#withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
  root to: 'homes#top'
end
