Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'launchpad#launchpad', as: :launchpad

  get '/dummy' => 'static#dummy'
  get '/subscriptions/new' => 'subscriptions#new', as: :new_subscription
  get '/groups/new' => 'groups#new', as: :new_group
  get '/posts/new' => 'posts#new', as: :new_post
  get '/login' => 'sessions#new', as: :login

  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: :logout
  
  post '/posts' => 'posts#create', as: :posts
  get '/posts/:id' => 'posts#show', as: :post
  get '/posts/:id/edit' => 'posts#edit', as: :edit_post
  patch '/posts/:id' => 'posts#update'
  post '/posts/:id/likes' => 'plusses#create', as: :plusses
  delete '/posts/:id' => 'posts#destroy'
  
  post '/requests' => 'requests#create', as: :requests
  delete '/requests' => 'requests#destroy'
  
  get '/groups' => 'groups#index', as: :groups
  post '/groups' => 'groups#create'
  get '/groups/:id' => 'groups#show', as: :group

  post '/blocks' => 'blocks#create', as: :blocks
  delete '/blocks' => 'blocks#destroy'

  post '/subscriptions' => 'subscriptions#create', as: :subscriptions

  get '/users/new' => 'users#new', as: :new_user
  post '/users' => 'users#create'
  get '/users/:username' => 'users#show'
  get '/users/:id' => 'users#show', as: :user
  get '/users/:id/edit' => 'users#edit', as: :edit_user
  patch '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'


  get '/friendships' => 'friendships#index', as: :friendships
  post '/friendships' => 'friendships#create'
  delete '/friendships' => 'friendships#destroy'


end
