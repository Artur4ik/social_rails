# frozen_string_literal: true

module API
  module V1
    module Posts
      class LikesController < V1::LikesController
        private

        def likeable = @likeable ||= Post.find(params[:post_id])
      end
    end
  end
end
