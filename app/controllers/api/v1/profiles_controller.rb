# frozen_string_literal: true

module API
  module V1
    class ProfilesController < BaseController
      include ActsLikeJwtTokenAuthorizable

      def show
        render json: ProfileSerializer.new(current_user),
               status: :ok
      end

      def update
        if current_user.update(permitted_params)
          render json: ProfileSerializer.new(current_user),
                 status: :ok
        else
          render json: ErrorSerializer.new(current_user),
                 status: :unprocessable_entity
        end
      end

      def destroy
        current_user.destroy

        head :no_content
      end

      private

      def permitted_params = params.permit(:avatar, :email, :password, :name, :country, :city, :sex, :birthdate, :bio)
    end
  end
end
