Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :show] do
    resources :employees, only: [:show]
    resources :products, only: [:new, :show, :destroy]
    resources :sales, only: [:new, :show, :destroy]
  end

  resources :products, only: [:create, :update]
  resources :sales, only: [:create, :update]
  resources :sessions, only: [:new, :create]

  get '/login', :to => 'sessions#new'
  get '/logout', :to => 'sessions#destroy'
  get '/users', :to => 'welcome#welcome'
  get '/hot_products', :to => 'products#hot_products'
  get '/users/:user_id/manager', :to => 'managers#show', :as => 'manager'
  get '/auth/facebook/callback' => 'sessions#create'
  get '/sales/by_quantity' => 'sales#by_quantity'
  get '/sale_data/:id' => 'sales#data'
  get '/users/:id/sales' => 'users#sales'

  root 'welcome#welcome'
end
