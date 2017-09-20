Rails.application.routes.draw do
  resources :fundings
  resources :funding_sources
  resources :card_products
  resources :cards
  resources :users
  root 'card_products#index'
  get '/payment/:token', to: 'cards#payment'
  post 'payment/:token', to: 'cards#sendPayment'

  get 'show_user/:token', to: 'users#show_user'
  get 'edit_user/:token', to: 'users#edit_user'
  patch 'user/:token', to: 'users#update_user'

  get 'edit_card_product/:token', to: 'card_products#edit_card_product'
  patch 'card_product/:token', to: 'card_products#update_card_product'

  get 'show_card/:token', to: 'cards#show_card'
  get 'activate_card/:token', to: 'cards#activate_card'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
