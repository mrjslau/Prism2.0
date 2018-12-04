Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'maps' => 'maps#index'
  get 'maps/new' => 'maps#new'
  post 'maps' => 'maps#create'
  get 'maps/:id' => 'maps#show'
end
