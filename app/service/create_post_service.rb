class CreatePostService
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    post = @user.posts.build(@params)

    if post.save
      success(post)
    else
      failure(post)
    end
  end

  private

  def success(post)
    OpenStruct.new(success?: true, post: post)
  end

  def failure(post)
    OpenStruct.new(success?: false, post: post)
  end
end