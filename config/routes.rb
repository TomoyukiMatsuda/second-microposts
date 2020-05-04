Rails.application.routes.draw do
  root 'toppages#index'
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]
end
