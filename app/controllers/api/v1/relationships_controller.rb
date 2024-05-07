# frozen_string_literal: true

module API
  module V1
    module Users
      class RelationshipsController < BaseController
        include ActsLikeJwtTokenAuthorizable

        def follow = follow_service.call ? head(:no_content) : head(:unprocessable_entity)
        def unfollow = unfollow_service.call ? head(:no_content) : head(:unprocessable_entity)

        private

        def target_user = User.find_by!(name: params[:user_name])
        def follow_service = Relationships::Actions::Follow.new(follower: current_user, followed: target_user)
        def unfollow_service = Relationships::Actions::Unfollow.new(follower: current_user, followed: target_user)
      end
    end
  end
end
