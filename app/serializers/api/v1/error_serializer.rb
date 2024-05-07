# frozen_string_literal: true

module API
  module V1
    class ErrorSerializer < BaseSerializer
      def initialize(model)
        @model = model
      end

      def as_json(_)
        {
          errors:
        }
      end

      private

      attr_reader :model

      def errors
        model.errors.map do |error|
          {
            status: error.options[:status] || 422,
            title: error.type,
            detail: error.message,
            source: {
              pointer: error.attribute
            }
          }
        end
      end
    end
  end
end
