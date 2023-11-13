Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update]
    get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"

  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
