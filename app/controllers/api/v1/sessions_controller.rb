# frozen_string_literal: true

module Api
  module V1
    class SessionsController < BaseController
      def create
        if authenticated?
          render json: session_creator.call,
                 status: :ok
        else
          render json: ErrorsSerializer.new(authenticator),
                 status: :unprocessable_entity
        end
      end

      private

      with_options to: :authenticator do
        delegate :authenticated?
        delegate :user
      end

      def authenticator
        @authenticator ||= AuthenticatorsFormObject::User.new(email: permitted_params[:email],
                                                              password: permitted_params[:password])
      end

      def session_creator
        @session_creator ||= Sessions::Create.new(authenticator.user)
      end

      def permitted_params
        @permitted_params ||= params
                              .require(:data)
                              .require(:attributes)
                              .permit(:email, :password)
      end
    end
  end
end
