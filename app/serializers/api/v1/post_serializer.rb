# frozen_string_literal: true

module Api
  module V1
    class PostSerializer
      include JSONAPI::Serializer

      belongs_to :user

      attributes :image,
                 :description,
                 :location,
                 :created_at,
                 :updated_at
    end
  end
end
