# frozen_string_literal: true

module Relationships
  module Actions
    class Base
      def initialize(follower:, followed:)
        @follower = follower
        @followed = followed
      end

      def call
        return if follower == followed

        run_action
      end

      private

      attr_reader :follower, :followed

      with_options to: :follower, private: true do
        delegate :follow!
        delegate :follow?
        delegate :unfollow!
      end

      def run_action = raise NotImplementedError
    end
  end
end
