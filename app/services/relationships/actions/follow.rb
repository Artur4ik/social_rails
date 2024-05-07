# frozen_string_literal: true

module Relationships
  module Actions
    class Follow < Base
      private

      def run_action
        return if follow?(followed)

        follow!(followed)
      end
    end
  end
end
