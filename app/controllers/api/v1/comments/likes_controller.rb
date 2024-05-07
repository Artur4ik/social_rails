# frozen_string_literal: true

module API
  module V1
    module Comments
      class LikesController < V1::LikesController
        private

        def likeable = @likeable ||= Comment.find_by!(id: params[:comment_id], post_id: params[:post_id])
      end
    end
  end
end
