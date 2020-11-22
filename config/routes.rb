Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :posts
  post   '/posts/like/:post_id' => 'likes#post_like',   as: 'post_like'
  delete '/posts/like/:post_id' => 'likes#post_unlike', as: 'post_unlike'
  resources :questions
  post   '/questions/like/:question_id' => 'likes#question_like',   as: 'question_like'
  delete '/questions/like/:question_id' => 'likes#question_unlike', as: 'question_unlike'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
