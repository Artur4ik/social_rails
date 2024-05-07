# frozen_string_literal: true

module API
  module V1
    class CommentsController < BaseController
      include ActsLikeJwtTokenAuthorizable

      before_action -> { authorize_user_access!(comment) }, only: %i[update destroy]

      def index
        render json: CommentSerializer.new(comments_pagination.paginate, { meta: meta(comments_pagination), include: }),
               status: :ok
      end

      def create
        @comment = post.comments.build(**permitted_params, user: current_user)

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
          head :no_content
        else
          render json: ErrorSerializer.new(comment),
                 status: :unprocessable_entity
        end
      end

      private

      def permitted_params = params.permit(:content)
      def comments = @comments ||= post.comments.order(created_at: :asc)
      def comments_pagination = @comments_pagination ||= Pagination.new(comments, page_params)
      def post = @post ||= PostsWithAssociationsQuery.query.find(params[:post_id])
      def comment = @comment ||= post.comments.find(params[:id])
    end
  end
end
