module Postable
    extend ActiveSupport::Concern
    
    included do
        before_action :set_post, only: %i[ show edit update destroy ]
    end

    private
    def set_post
        @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
        params.expect(post: [ :title, :content, :user_id, attachments: [] ])
    end

end
