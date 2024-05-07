# frozen_string_literal: true

module API
  module V1
    class CommentSerializer < BaseSerializer
      belongs_to :post
      belongs_to :user

      attributes :content
    end
  end
end
