# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      include ActsLikeJwtTokenAuthorizable

      before_action :authorize_user!, except: %i[create]

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

      def update
        if current_user.update(permitted_params)
          render json: UserSerializer.new(current_user),
                 status: :ok
        else
          render json: ErrorSerializer.new(current_user),
                 status: :unprocessable_entity
        end
      end

      def show
        render json: UserSerializer.new(user),
               status: :ok
      end

      def destroy
        if current_user.destroy
          render json: {},
                 status: :no_content
        else
          render json: {},
                 status: :internal_server_error
        end
      end

      def profile
        render json: UserQuery.new(user:).call,
               status: :ok
      end

      private

      def permitted_params
        params
          .require(:data)
          .require(:attributes)
          .permit(:avatar, :email, :password, :name, :country, :city, :sex, :birthdate, :bio)
      end

      def user
        return @user if defined? @user

        find_user(params[:id] || params[:user_id])
      end

      def find_user(id)
        @user = User.find_by(name: id) || User.find(id)
      end
    end
  end
end
