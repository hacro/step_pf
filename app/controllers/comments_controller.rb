class CommentsController < ApplicationController

    def create
        post = Post.find(params[:post_id])
        comment = current_user.comments.new(post_comment_params)
        comment.post_id = post.id
        comment.save
        redirect_back(fallback_location: post_path(post))
    end



    private
    def post_comment_params
        params.require(:comment).permit(:comment)
    end
end
