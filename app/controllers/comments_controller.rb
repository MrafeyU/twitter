class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.comments.create(comment_params.merge(user: current_user))
    redirect_to @post
  end
  private
  def comment_params
    params.expect(comment: [ :content, :user_id ])
  end
end
