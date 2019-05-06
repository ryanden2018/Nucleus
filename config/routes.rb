Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dummy' => 'static#dummy'
  get '/groups/new' => 'groups#new', as: :new_group
  get '/posts/new' => 'posts#new', as: :new_post
  get '/login' => 'sessions#new', as: :login
  get '/subscriptions/new' => 'subscriptions#new', as: :new_subscription

  post '/login' => 'sessions#create'
  get '/launchpad' => 'users#index', as: :launchpad
  delete '/logout' => 'sessions#destroy', as: :logout
  
  post '/posts' => 'posts#create', as: :posts
  get '/posts/:id' => 'posts#show', as: :post
  
  get '/groups' => 'groups#index', as: :groups
  post '/groups' => 'groups#create'
  get '/groups/:id' => 'groups#show', as: :group
  
  
  

  resources :friendships
end
