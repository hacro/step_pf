class CommentsController < ApplicationController
    GOOGLE_API_KEY = ENV['GOOGLE_API_SECRET_KEY']

    def create
        post = Post.find(params[:post_id])
        comment = current_user.comments.new(post_comment_params)
        comment.post_id = post.id
        if comment.save
            redirect_to post_path(post)
            flash[:commentSuccessMsg] = 'コメントを投稿しました！'
            # redirect_back(fallback_location: post_path(post))
        else
            @google_api_key = GOOGLE_API_KEY
            @post = Post.find(params[:post_id])
            @comment = Comment.new
            flash[:commentErrorMsg] = 'コメントを入力してください。'
            render 'posts/show'
        end
    end

    def destroy
        post = Post.find(params[:post_id])
        Comment.find(params[:post_id]).destroy
        redirect_back(fallback_location: post_path(post))

    end



    private
    def post_comment_params
        params.require(:comment).permit(:comment)
    end
end
