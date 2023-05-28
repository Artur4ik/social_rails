# frozen_string_literal: true

module Api
  module V1
    class PostsController < BaseController
      include ActsLikeJwtTokenAuthorizable

      def index
        render json: PostSerializer.new(posts),
               status: :ok
      end

      def create
        @post = post.new(**permitted_params, user: current_user)

        if post.save
          render json: PostSerializer.new(post),
                 status: :ok
        else
          render json: ErrorSerializer.new(post),
                 status: :unprocessable_entity
        end
      end

      def update
        if post.update(permitted_params)
          render json: PostSerializer.new(post),
                 status: :ok
        else
          render json: ErrorSerializer.new(post),
                 status: :unprocessable_entity
        end
      end

      def show
        render json: PostSerializer.new(post),
               status: :ok
      end

      def destroy
        if post.destroy
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
          .permit(:content, :image)
      end

      def posts
        @posts ||= current_user.posts
      end

      def post
        @post ||= posts.find(params[:id])
      end
    end
  end
end
