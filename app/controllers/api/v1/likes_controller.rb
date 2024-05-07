# frozen_string_literal: true

module API
  module V1
    class LikesController < BaseController
      include ActsLikeJwtTokenAuthorizable

      def create
        @like = likeable.likes.create(user: current_user) unless like

        render json: LikeSerializer.new(like),
               status: :created
      end

      def destroy
        like&.destroy

        head :no_content
      end

      private

      def like = @like ||= likeable.like(current_user)
      def likeable = raise NotImplementedError
    end
  end
end
