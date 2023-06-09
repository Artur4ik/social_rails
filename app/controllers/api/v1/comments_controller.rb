# frozen_string_literal: true

module Api
  module V1
    class CommentsController < BaseController
      include ActsLikeJwtTokenAuthorizable

      def index
        render json: CommentSerializer.new(comments),
               status: :ok
      end

      def create
        @comment = Comment.new(**permitted_params,
                               post:,
                               user: current_user)

        if comment.save
          render json: CommentSerializer.new(comment),
                 status: :ok
        else
          render json: ErrorSerializer.new(comment),
                 status: :unprocessable_entity
        end
      end

      def update
        if comment.update(permitted_params)
          render json: CommentSerializer.new(comment),
                 status: :ok
        else
          render json: ErrorSerializer.new(comment),
                 status: :unprocessable_entity
        end
      end

      def show
        render json: CommentSerializer.new(comment),
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
          .permit(:content)
      end

      def comments
        @comments ||= post.comments
      end

      def comment
        @comment ||= comments.find(params[:id])
      end

      def post
        @post ||= Post.find(params[:post_id])
      end
    end
  end
end
