# frozen_string_literal: true

module Api
  module V1
    class CommentsSerializer
      include JSONAPI::Serializer

      attributes :content,
                 :commentable_id,
                 :commentable_type,
                 :user_id,
                 :created_at,
                 :updated_at
    end
  end
end
