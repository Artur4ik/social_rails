# frozen_string_literal: true

module Api
  module V1
    module CommentsFormObject
      class Create
        attr_reader :comment

        with_options to: :comment do
          delegate :save
          delegate :errors
          delegate :valid?
        end

        def initialize(current_user:, attributes:)
          @comment = Comment.new(
            content: attributes[:content],
            commentable_id: attributes[:commentable_id],
            commentable_type: attributes[:commentable_type].presence_in(Comment::COMMENTABLE_TYPES),
            user: current_user
          )
        end
      end
    end
  end
end
