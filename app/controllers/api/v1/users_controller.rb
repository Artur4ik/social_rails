# frozen_string_literal: true

module API
  module V1
    class UsersController < BaseController
      include ActsLikeJwtTokenAuthorizable

      skip_before_action :authorize_user!, only: :create

      def create
        @user = User.new(permitted_params)

        if user.save
          render json: UserSerializer.new(user),
                 status: :ok
        else
          render json: ErrorSerializer.new(user),
                 status: :unprocessable_entity
        end
      end

      def show
        render json: UserSerializer.new(user, include:),
               status: :ok
      end

      private

      def permitted_params = params.permit(:avatar, :email, :password, :name, :country, :city, :sex, :birthdate, :bio)
      def user = @user ||= UsersWithAssociationsQuery.query.find_by!(name: params[:name])
    end
  end
end
