Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users

  get "/users/mypage" => "users#mypage", as: "mypage"
  get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
  patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"

  resources :users, only: [:show, :edit, :update, :mypage, :unsubscribe, :destroy] do
    resources :follows, only: [:create, :destroy, :index]
        # get "followings" => "follows#followings", as: "followings"
        # get "followers" => "follows#followers", as: "followers"
  end
  resources :posts do
    collection do
      get "search"
    end
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end

  resources :favorites, only: [:index]


  get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
