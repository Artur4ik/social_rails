# frozen_string_literal: true

module Api
  module V1
    class LikeSerializer
      include JSONAPI::Serializer

      belongs_to :user
      belongs_to :likeable, polymorphic: true

      attributes :created_at, :destroyed?
    end
  end
end
