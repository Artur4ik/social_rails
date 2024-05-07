# frozen_string_literal: true

module API
  module V1
    class UsersWithAssociationsQuery
      def self.query = new.query

      def query = User.with_attached_avatar.includes(posts: [likes, comments, image])

      private

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

      def likes = :likes
      def comments = { comments: :likes }
    end
  end
end
