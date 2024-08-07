Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:create, :show, :update, :destroy]
  resources :posts, except: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
  root to: 'homes#top'
  get '/about' => 'homes#about'
end
