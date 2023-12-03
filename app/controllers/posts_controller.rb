class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_image_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
  end
  def search
    search_word = params[:keyword]
    @posts = Post.where('location LIKE?', "%#{search_word}%")
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])

  end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_image_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end


  private

  def post_image_params
    params.require(:post).permit(:spot_type_id, :caption, :location, :spot_detail, :other_info, :image)
  end

end
