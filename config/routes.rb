Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tools do
    resources :bookings
    resources :reviews, only: [:new, :create]
  end
  get "/account", to: "account#show"
  get "/home", to: "pages#home"
  post "/confirm", to: "bookings#confirm"
  post "/decline", to: "bookings#decline"
  post "/cancel", to: "bookings#cancel"

end
