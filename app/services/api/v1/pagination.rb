# frozen_string_literal: true

module API
  module V1
    class Pagination
      DEFAULT_PAGE = 1
      DEFAULT_PER_PAGE = 5

      attr_reader :collection, :page, :per_page

      def initialize(collection, page_params)
        @collection = collection
        @page = (page_params.dig(:page, :page) || DEFAULT_PAGE).to_i
        @per_page = (page_params.dig(:page, :per_page) || DEFAULT_PER_PAGE).to_i
      end

      def paginate = collection.limit(per_page).offset(offset)

      def page_count = (collection.size.to_f / per_page).ceil

      private

      def offset = per_page * (page - 1)
    end
  end
end
