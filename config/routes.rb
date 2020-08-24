Rails.application.routes.draw do
  get 'tools/index'
  get 'tools/show'
  get 'tools/new'
  get 'tools/edit'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tools do
    resources :bookings
  end
  get "/account", to: "account#show"
end
