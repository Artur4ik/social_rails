# frozen_string_literal: true

module API
  module V1
    module ActsLikeMultilingualAPI
      extend ActiveSupport::Concern

      included do
        before_action :set_locale!
      end

      private

      def set_locale!
        I18n.locale = locale if locale.in?(I18n.available_locales)
      end

      def locale
        request.headers.fetch('Accept-Language', 'en').to_sym
      end
    end
  end
end
