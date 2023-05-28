# frozen_string_literal: true

module Api
  module V1
    module ActsLikeJwtTokenAuthorizable
      extend ActiveSupport::Concern

      included do
        before_action :authorize_user!

        attr_reader :current_user

        rescue_from JWT::ExpiredSignature, JWT::DecodeError do
          render json: invalid_token_error,
                 status: :forbidden
        end
      end

      private

      def authorize_user!
        @current_user = User.find_by(id: payload[:user_id])

        raise JWT::DecodeError unless current_user
      end

      def bearer_token
        request
          .headers
          .fetch('Authorization', '')
          .gsub(/^[B|b]earer /, '')
      end

      def payload
        Jwt::Decode
          .new(bearer_token)
          .call
          .with_indifferent_access
      end

      def invalid_token_error
        {
          data: {
            status: 403,
            title: :forbidden,
            detail: 'Access token invalid.'
          }
        }
      end
    end
  end
end
