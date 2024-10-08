# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'profile#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  resources :posts

  # Resources for signup
  resources :users, only: [:new, :create]
  resources :posts do
    resources :comments, only: [:create, :destroy] do
      resource :like, only: [:create, :destroy]
    end
    resource :like, only: [:create, :destroy]
  end

  resources :comments, only: [] do
    resource :like, only: [:create, :destroy]
  end

  get 'confirm', to: 'users#confirm', as: 'confirm_user'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
