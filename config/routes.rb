Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:create, :show, :update, :destroy]
  resources :posts, except: [:show]
  resources :users, only: [:index, :show, :edit, :update]
  get '/users/:id/confirm' => 'users#confirm'
  patch 'users/withdraw' => 'users#withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
  root to: 'homes#top'
  get '/about' => 'homes#about'
end
