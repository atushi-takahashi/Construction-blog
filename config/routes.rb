Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :posts
  resources :questions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
