Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'launchpad#launchpad', as: :launchpad
  get '/dummy' => 'static#dummy'

  resources :subscriptions, only: [:new,:create,:destroy]
  resources :groups, only: [:index,:show,:new,:create,:edit,:update,:destroy]
  resources :posts, only: [:show,:new,:create,:edit,:update,:destroy]
  resources :sessions, only: [:new,:create,:destroy]
  resources :plusses, only: [:create,:destroy]
  resources :comments, only: [:create,:edit,:update,:destroy]
  resources :requests, only: [:create,:destroy]
  resources :blocks, only: [:create,:destroy]
  resources :users, only: [:show,:new,:create,:edit,:update,:destroy]
  resources :friendships, only: [:index,:create,:destroy]

  delete '/sessions' => 'sessions#destroy'
end
