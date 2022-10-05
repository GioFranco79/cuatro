Rails.application.routes.draw do
  mount ShopifyApp::Engine, at: '/'

  post 'callback/:id', to: 'callback#search'

  resources :rates

  get 'retry', to: 'home#retry'

  namespace :admin do
    resources :shops, only: [:show]
  end

  root to: 'home#index'
end
