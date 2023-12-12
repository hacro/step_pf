class PostsController < ApplicationController

  GOOGLE_API_KEY = ENV['GOOGLE_API_SECRET_KEY']

  def new
    @google_api_key = GOOGLE_API_KEY
    @post = Post.new
  end

  def create
    @post = Post.new(post_image_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      @google_api_key = GOOGLE_API_KEY
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
  end
  def search
    search_word = params[:keyword]
    @posts = Post.where('location LIKE?', "%#{search_word}%").order(created_at: :desc)
  end

  def show
    @google_api_key = GOOGLE_API_KEY
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @google_api_key = GOOGLE_API_KEY
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_image_params)
      redirect_to post_path(@post)
    else
      @google_api_key = GOOGLE_API_KEY
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
