# frozen_string_literal: true

module Api
  module V1
    module ActsLikeJwtTokenAuthenticatable
      extend ActiveSupport::Concern

      included do
        before_action :authenticate_user!, only: %i[create update destroy]

        attr_accessor :current_user

        rescue_from JWT::ExpiredSignature, JWT::DecodeError do
          render json: {},
                 status: :forbidden
        end
      end

      private

      def authenticate_user!
        current_user = User.find_by(id: payload[:user_id])

        raise JWT::DecodeError unless current_user
      end

      def bearer_token
        request
          .headers
          .fetch('Authorization', '')
          .gsub(/^[B|b]earer /, '')
      end

      def payload
        Jwt::Decode.new(bearer_token).call
      end
    end
  end
end
