Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions
  delete '/exit' => 'sessions#destroy', as: :logout # as决定具名路由, 第一个'/exit' 决定路由

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
