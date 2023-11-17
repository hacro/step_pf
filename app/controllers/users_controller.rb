class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_withdrawal: true)
    reset_session
    flash[:notice] = "退会処理が完了しました"
    redirect_to root_path
  end


end
