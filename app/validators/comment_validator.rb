# frozen_string_literal: true

class CommentValidator < ActiveModel::Validator
  COMMENTABLE_TYPES = %w[
    Post
  ].freeze

  def validate(comment)
    @comment = comment

    check_commentable_type
    check_commentable_id if errors[:commentable_type].empty?
  end

  private

  attr_reader :comment

  with_options to: :comment do
    delegate :commentable_id
    delegate :commentable_type
    delegate :errors
  end

  def check_commentable_type
    return if commentable_type.in?(COMMENTABLE_TYPES)

    errors.add(:commentable_type, :invalid)
  end

  def check_commentable_id
    return if commentable_type.constantize.public_send(:find_by, id: commentable_id)

    errors.add(:commentable_id, :invalid)
  end
end
