Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions
  delete '/exit' => 'sessions#destroy', as: :logout # as决定具名路由, 第一个'/exit' 决定路由

  resources :categories, only: [:show]
  resources :products, only: [:show]

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images, only: [:index, :create, :destroy, :update]
    end
  end
end
