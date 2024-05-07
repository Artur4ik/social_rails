# frozen_string_literal: true

module Relationships
  module Actions
    class Unfollow < Base
      private

      def run_action
        return unless follow?(followed)

        unfollow!(followed)
      end
    end
  end
end
