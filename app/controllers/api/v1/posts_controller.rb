# frozen_string_literal: true

module API
  module V1
    class PostsController < BaseController
      include ActsLikeJwtTokenAuthorizable

      before_action -> { authorize_user_access!(post) }, only: %i[update destroy]

      def index
        render json: PostSerializer.new(posts_pagination.paginate, { meta: meta(posts_pagination) }),
               status: :ok
      end

      def create
        @post = posts.build(**permitted_params, user: current_user)

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
        post.destroy

        head :no_content
      end

      def feed
        render json: PostSerializer.new(current_user_feed_pagination.paginate,
                                        { meta: meta(current_user_feed_pagination), include: }),
               status: :ok
      end

      private

      def permitted_params = params.permit(:location, :image, :description)
      def posts = @posts ||= Post.order(created_at: :desc)
      def posts_pagination = @posts_pagination ||= Pagination.new(posts, page_params)
      def post = @post ||= posts.find(params[:id])
      def current_user_feed = UserFeedWithAssociationsQuery.query(current_user)

      def current_user_feed_pagination
        @current_user_feed_pagination ||= Pagination.new(current_user_feed, page_params)
      end
    end
  end
end
