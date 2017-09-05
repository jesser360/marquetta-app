Rails.application.routes.draw do
  resources :fundings
  resources :funding_sources
  resources :card_products
  resources :cards
  resources :users
  root 'card_products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
