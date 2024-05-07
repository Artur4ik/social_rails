# frozen_string_literal: true

module API
  module V1
    class BaseController < ApplicationController
      include ActiveStorage::SetCurrent
      include ActsLikeMultilingualAPI

      skip_before_action :verify_authenticity_token

      rescue_from ActionDispatch::Http::Parameters::ParseError, ActionController::ParameterMissing do
        render json: bad_request_error,
               status: :bad_request
      end

      rescue_from ActiveRecord::RecordNotFound, JSONAPI::Serializer::UnsupportedIncludeError do
        render json: record_not_found_error,
               status: :not_found
      end

      rescue_from API::V1::ForbiddenException do
        render json: forbidden_error,
               status: :forbidden
      end

      private

      def authorize_user_access!(target)
        return if target.user == current_user

        raise ForbiddenException
      end

      def base_error(status:, title:)
        {
          errors: [
            {
              status:,
              title:
            }
          ]
        }
      end

      def bad_request_error = base_error(status: 400, title: 'bad_request')
      def record_not_found_error = base_error(status: 404, title: 'not_found')
      def forbidden_error = base_error(status: 403, title: 'forbidden')

      def include = params.fetch(:include, '').delete(' ').split(',').to_a
      def meta(collection) = { per_page: collection.per_page, page: collection.page, page_count: collection.page_count }
      def page_params = params.permit(page: %i[page per_page])
    end
  end
end
