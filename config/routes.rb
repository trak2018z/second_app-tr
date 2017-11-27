Rails.application.routes.draw do
  root 'posts#index'

  get 'session/new'

  get 'user/new'
  get 'users/new'
  get '/info', to: 'basic_pages#info'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  put '/upvote', to: 'posts#upvote'
  put '/downvote', to: 'posts#downvote'
  get 'post/getPointAmount'
  resources :posts do
    resources :comments
  end
  resources :users
end
