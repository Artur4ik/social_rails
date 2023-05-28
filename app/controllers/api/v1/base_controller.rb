# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ActsLikeMultilingualApi

      skip_before_action :verify_authenticity_token

      rescue_from ActionDispatch::Http::Parameters::ParseError, ActionController::ParameterMissing do |exception|
        render json: missing_attribute_error(exception.message),
               status: :bad_request
      end

      rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: record_not_found_error(exception.message),
               status: :not_found
      end

      private

      def missing_attribute_error(message)
        {
          errors: [
            {
              status: 400,
              title: 'blank',
              detail: message
            }
          ]
        }
      end

      def record_not_found_error(message)
        {
          errors: [
            {
              status: 404,
              title: 'not_found',
              detail: message
            }
          ]
        }
      end
    end
  end
end
