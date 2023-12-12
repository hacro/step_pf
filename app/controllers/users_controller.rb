class UsersController < ApplicationController
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

  # def favorited_posts
  #   @favorited_posts = Post.favorited_posts(current_user)
  # end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
