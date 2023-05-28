# frozen_string_literal: true

module Api
  module V1
    class SessionsController < BaseController
      def create
        authenticator = Authenticators::User.new(email:, password:)

        if authenticator.valid?
          render json: {}
        else
          render json: ErrorsSerializer.new(authenticator),
                 status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params
          .require(:data)
          .require(:attributes)
          .permit(:email, :password)
      end

      def email
        permitted_params[:email]
      end

      def password
        permitted_params[:password]
      end
    end
  end
end
