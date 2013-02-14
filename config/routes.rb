Petyard::Application.routes.draw do
  get 'players_online' => 'home#players_online', :as => :players_online
  get 'map' => 'home#map', :as => :map

  resources :projects do
    member do
      get 'join'
    end

    resources :project_memberships
  end

  resources :mod_messages

  resources :forum_categories, :except => [:show]

  resources :forums do
    resources :topics, :except => [:index] do
      resources :posts, :except => [:index, :show]
    end
  end

  get 'forums/:forum_id/:topic_id/new' => 'posts#new', :as => :new_forum_topic_post
  get 'forums/:forum_id/:topic_id/:id/edit' => 'posts#edit', :as => :edit_forum_topic_post

  get 'forums/:forum_id/new' => 'topics#new', :as => :new_forum_topic
  get 'forums/:forum_id/:id/edit' => 'topics#edit', :as => :edit_forum_topic
  get 'forums/:forum_id/:id' => 'topics#show', :as => :forum_topic
  put 'forums/:forum_id/:id' => 'topics#update'
  delete 'forums/:forum_id/:id' => 'topics#destroy'

  get 'register' => 'users#new', :as => :register
  get 'account' => 'users#edit', :as => :account
  match 'account/:id/remove_avatar' => 'users#remove_avatar', :as => :remove_avatar
  get 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  get 'profile/:id' => 'users#show', :as => :user
  put 'profile/:id' => 'users#update'
  delete 'profile/:id' => 'users#destroy'
  resources :users
  resources :user_sessions

  resources :ranks

  get 'notify' => 'home#notify', :as => :notify

  resources :features
  
  root :to => 'home#index'
end
