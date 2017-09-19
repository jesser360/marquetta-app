Rails.application.routes.draw do
  resources :fundings
  resources :funding_sources
  resources :card_products
  resources :cards
  resources :users
  root 'card_products#index'
  get '/payment/:id', to: 'cards#payment'
  post 'payment/:id', to: 'cards#sendPayment'
  get 'show_user/:token', to: 'users#show_user'
  get 'edit_user/:token', to: 'users#edit_user'
  patch 'user/:token', to: 'users#update_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
