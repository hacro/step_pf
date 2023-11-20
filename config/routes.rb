Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users

  get "/users/mypage" => "users#mypage", as: "mypage"
  get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
  patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"
  resources :users, only: [:show, :edit, :update]
  
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
