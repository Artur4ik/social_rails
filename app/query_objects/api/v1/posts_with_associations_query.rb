# frozen_string_literal: true

module API
  module V1
    class PostsWithAssociationsQuery
      def self.query = new.query

      def query = Post.includes(comments, likes)

      private

      def comments
        {
          comments: {
            user:
          }
        }
      end

      def user
        [
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
      end

      def likes = :likes
    end
  end
end
