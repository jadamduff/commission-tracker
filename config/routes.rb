Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :show] do
    resources :employees, only: [:show]
    resources :products, only: [:new, :show]
    resources :sales, only: [:new, :show]
  end

  resources :products, only: [:create, :update]
  resources :sales, only: [:create, :update]
  resources :sessions, only: [:new, :create, :destroy]

  get '/login', :to => 'sessions#new'
  get '/logout', :to => 'sessions#destroy'
  get '/users', :to => 'welcome#welcome'
  get '/users/:user_id/manager', :to => 'managers#show', :as => 'manager'
  get '/auth/facebook/callback' => 'sessions#create'

  root 'welcome#welcome'
end
