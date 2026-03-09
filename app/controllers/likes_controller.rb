class LikesController < ApplicationController
  def create
    @post.likes.create(user: current_user)
  end
end
