# frozen_string_literal: true

module Api
  module V1
    class CommentsController < BaseController
      include ActsLikeJwtTokenAuthorizable

      def index
        render json: CommentsSerializer.new(comments),
               status: :ok
      end

      def create
        @comment = CommentsFormObject::Create.new(current_user:, attributes: permitted_params)

        if comment.save
          render json: CommentsSerializer.new(comment),
                 status: :ok
        else
          render json: ErrorsSerializer.new(comment),
                 status: :unprocessable_entity
        end
      end

      def update
        if comment.update(permitted_params)
          render json: CommentsSerializer.new(comment),
                 status: :ok
        else
          render json: ErrorsSerializer.new(comment),
                 status: :unprocessable_entity
        end
      end

      def show
        render json: CommentsSerializer.new(comment),
               status: :ok
      end

      def destroy
        if comment.destroy
          render json: {},
                 status: :no_content
        else
          render json: {},
                 status: :internal_server_error
        end
      end

      private

      def permitted_params
        params
          .require(:data)
          .require(:attributes)
          .permit(:content, :commentable_type, :commentable_id)
      end

      def comments
        @comments ||= current_user.comments
      end

      def comment
        @comment ||= comments.find(params[:id])
      end
    end
  end
end
