# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_locale!

      rescue_from ActionDispatch::Http::Parameters::ParseError, ActionController::ParameterMissing do |_exception|
        render json: {},
               status: :bad_request
      end

      rescue_from ActiveRecord::RecordNotFound do |_exception|
        render json: {},
               status: :not_found
      end

      def set_locale!
        I18n.locale = locale if locale.in?(I18n.available_locales)
      end

      def locale
        request.headers.fetch('Accept-Language', 'en').to_sym
      end
    end
  end
end
