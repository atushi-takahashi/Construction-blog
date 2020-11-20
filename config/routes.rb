Rails.application.routes.draw do
  get 'questions/show'
  get 'questions/edit'
  get 'questions/new'
  get 'questions/index'
  get 'posts/show'
  get 'posts/edit'
  get 'posts/new'
  get 'posts/index'
  root to: 'homes#top'
  get 'homes/about'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
