Rails.application.routes.draw do
  root 'users#index'

  resources :users
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/maps', to: 'maps#index'
end
