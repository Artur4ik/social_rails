# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def index
        render json: UsersSerializer.new(User.all),
               status: :ok
      end

      def create
        user = User.new(permitted_params)

        if user.save
          render json: UsersSerializer.new(user),
                 status: :ok
        else
          render json: ErrorsSerializer.new(user),
                 status: :unprocessable_entity
        end
      end

      def show
        user = User.find(params[:id])

        render json: UsersSerializer.new(user),
               status: :ok
      end

      def destroy
        user = User.find(params[:id])

        if user.destroy
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
          .permit(:email, :password)
      end
    end
  end
end
