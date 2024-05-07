# frozen_string_literal: true

module API
  module V1
    class UserFeedWithAssociationsQuery
      def self.query(user) = new(user).query

      def initialize(user) = @user = user
      def query = user.feed.includes(user_associations, image, likes, comments).order(created_at: :desc)

      private

      attr_reader :user

      def image
        {
          image_attachment: {
            blob: {
              variant_records: { image_attachment: :blob },
              preview_image_attachment: { blob: { variant_records: { image_attachment: :blob } } }
            }
          }
        }
      end

      def user_associations
        {
          user: [
            {
              avatar_attachment: {
                blob: {
                  variant_records: { image_attachment: :blob },
                  preview_image_attachment: { blob: { variant_records: { image_attachment: :blob } } }
                }
              }
            },
            :posts
          ]
        }
      end

      def likes = :likes
      def comments = :comments
    end
  end
end
