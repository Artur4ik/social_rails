# frozen_string_literal: true

module Api
  module V1
    class CommentSerializer
      include JSONAPI::Serializer

      belongs_to :post
      belongs_to :user

      attributes :content,
                 :created_at,
                 :updated_at
    end
  end
end
