class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_image_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def edit
  end

  def show
  end

  private

  def post_image_params
    params.require(:post).permit(:spot_type_id, :caption, :location, :spot_detail, :other_info, :image)
  end
end
