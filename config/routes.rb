Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  get '/new_entry', to: 'entries#new'

  resources :warehouses, only: [:show, :new, :create, :edit, :update] do
    post 'product_entry', on: :member
    get 'search', on: :collection, to: 'warehouses#search'
  end
  get '/warehouses', to: redirect('/')

  resources :suppliers, only: [:index, :show, :new, :create]

  resources :product_types, only:[:show, :new, :create, :edit, :update]

  resources :product_bundles, only: [:show, :new, :create]

  resources :product_categories, only: [:index, :show, :new, :create]
end
