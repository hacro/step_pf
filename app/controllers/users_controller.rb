class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :unlogin_user, only: [:edit,:show, :unsubscribe, :destroy, :update]
  before_action :is_matching_login_user, only: [:edit, :update, :unsubscribe, :destroy]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def mypage
    @user = current_user
  end

  def unsubscribe
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    flash[:notice] = "退会処理が完了しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


  def is_matching_login_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to posts_path
    end
  end

end
