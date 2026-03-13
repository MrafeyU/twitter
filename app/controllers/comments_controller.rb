class CommentsController < ApplicationController
  def create
    # set_post
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    authorize @comment

    if @comment.save
      redirect_to @post
    else
      redirect_to @post
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy

    redirect_to @comment.post
  end


  private
    def comment_params
      params.expect(comment: [ :content, :user_id ])
    end
end
