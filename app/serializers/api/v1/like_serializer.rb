# frozen_string_literal: true

module API
  module V1
    class LikeSerializer < BaseSerializer
      belongs_to :likeable, polymorphic: true

      attributes :user_id
    end
  end
end
