class FavoritesController < ApplicationController
    # before_action :authenicate_user!
    before_action :unlogin_user

    def create
        @post = Post.find(params[:post_id])
        @favorite = current_user.favorites.create(post_id: params[:post_id])
    end

    def destroy
    # どのポストかを取ってきて@postに格納
        @post = Post.find(params[:post_id])
        @favorite = current_user.favorites.find_by(post_id: @post.id)
        @favorite.destroy
    end

    def index
        favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
        @favorite_posts = Post.find(favorites)
    end

    private
    def unlogin_user
        unless user_signed_in?
            redirect_to new_user_session_path
        end
    end

end
