Rails.application.routes.draw do
  get 'homes/top'
  devise_for :users ,controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admins  ,controllers: {
    sessions: 'admins/sessions'
  }
  scope module: :user do
    root to: 'homes#top'
    get 'homes/about'
    resources :users, only: [:show, :edit, :update] do
      post 'follow/:id', to: 'relationships#follow', as: 'follow'
      post 'unfollow/:id', to: 'relationships#unfollow', as: 'unfollow'
      get 'following/:user_id', to: 'users#following', as: 'following'
      get 'follower/:user_id', to: 'users#follower', as: 'follower'
    end
    resources :posts do
      post   '/like/:id' => 'likes#post_like',   as: 'like'
      delete '/like/:id' => 'likes#post_unlike', as: 'unlike'
      post   '/comment/:id' => 'comments#post_create', as: 'create_comment'
      delete '/comment/:id' => 'comments#post_destroy', as: 'destroy_comment'
      get '/report/new' => 'reports#post_report_new', as: 'report_new'
      post   '/report' => 'reports#post_report_create', as: 'report_create'
    end
    resources :questions do
      post   '/like/:id' => 'likes#question_like',   as: 'like'
      delete '/like/:id' => 'likes#question_unlike', as: 'unlike'
      post   '/comment/:id' => 'comments#question_create', as: 'create_comment'
      delete '/comment/:id' => 'comments#question_destroy', as: 'destroy_comment'
      get '/report/new' => 'reports#question_report_new', as: 'report_new'
      post   '/report' => 'reports#question_report_create', as: 'report_create'
    end
    resources :direct_messages, only: [:create, :destroy]
    resources :rooms, only: [:create, :index, :show]
    resources :notifications, only: :index
    delete '/notifications' => 'notifications#destroy_all', as: 'all_destroy'
  end
  namespace :admins do
    get 'homes/top', as: 'homes'
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:index, :show, :update]
    resources :questions, only: [:index, :show, :update]
    resources :notifications, only: :index
    delete '/notifications' => 'notifications#destroy_all', as: 'all_destroy'
    resources :reports, only: [:index, :show, :destroy, :update]
    patch '/report/:id' => 'reports#delete_flag_update', as: 'delete_flag_update'
  end

end