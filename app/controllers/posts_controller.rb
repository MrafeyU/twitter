class PostsController < ApplicationController
  # before_action :set_post, only: %i[ show edit update destroy ]
  include Postable
  before_action :authenticate_user!, only: %i[ new edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = policy_scope(Post).with_attached_attachments.order(created_at: :desc)
    
  end

  # GET /posts/1 or /posts/1.json
  def show
     authorize @post
    @post.increment!(:views)
    # render json: @post
  end

  # GET /posts/new
  def new
    @post = Post.new
      authorize @post
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
     authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
       authorize @post
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def remove_attachment
  @post = Post.find(params[:id])
  attachment = @post.attachments.find(params[:attachment_id])
  attachment.purge

  redirect_back fallback_location: edit_post_path(@post)
end

end


# authorize @post: 
# Here’s what happens:
# Pundit looks for a policy class for the object’s class.
# For @post (instance of Post), Pundit looks for PostPolicy.
# It infers the action based on the controller action.
# For example, in edit, it will try to call PostPolicy#edit?.
# In update, it calls PostPolicy#update?.
# It passes the current user to the policy:
# PostPolicy.new(current_user, @post)
# The policy returns true or false.
# If true → execution continues.
# If false → Pundit::NotAuthorizedError is raised.
# So basically, authorize checks “does this user have permission to do this action on this object?”