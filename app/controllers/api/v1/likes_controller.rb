# frozen_string_literal: true

module Api
  module V1
    class LikesController < BaseController
      include ActsLikeJwtTokenAuthorizable

      def create
        if like_form_object.save
          render json: LikeSerializer.new(like_form_object.like),
                 status: :ok
        else
          render json: {},
                 status: :unprocessable_entity
        end
      end

      private

      def like_form_object
        @like_form_object ||= ::LikeFormObject.new(likeable_id: permitted_params[:likeable_id],
                                                   likeable_type: permitted_params[:likeable_type],
                                                   user: current_user)
      end

      def permitted_params
        @permitted_params ||=
          params
          .require(:data)
          .require(:attributes)
          .permit(:user_id, :likeable_id, :likeable_type)
      end
    end
  end
end
