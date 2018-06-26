Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'movies#index'

  get 'transactions/dashboard', to: 'transactions#dashboard'

  resources :movies, only: [:index, :show]
  resources :showings, only: [:show]
  resources :transactions, only: [:create, :show, :index]
end
