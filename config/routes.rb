Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users

  get "/users/mypage" => "users#mypage", as: "mypage"
  get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
  patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"

  resources :users do
    resource :follows, only: [:create, :destroy]
      get "followings" => "follows#followings", as: "followings"
      get "followers" => "follows#followers", as: "followers"
  end
  # resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end

  get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
