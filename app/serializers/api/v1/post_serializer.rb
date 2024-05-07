# frozen_string_literal: true

module API
  module V1
    class PostSerializer < BaseSerializer
      belongs_to :user

      has_many :likes
      has_many :comments

      attributes :description,
                 :location

      attribute(:image) { |object| object.image.url }
    end
  end
end
