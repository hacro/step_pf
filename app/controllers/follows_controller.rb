class FollowsController < ApplicationController
  before_action :unlogin_user
  
  # フォローする時
  def create
    @user = User.find(params[:user_id])
    follow = current_user.follow(@user)
  end

  # フォローを外す時
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end

  def index
    @user = User.find(params[:user_id])
    @followings = @user.followings
    @followers = @user.followers
  end

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

  private
  def unlogin_user
    unless user_signed_in?
        redirect_to new_user_session_path
    end
end
end
