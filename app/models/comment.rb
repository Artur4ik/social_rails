# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  COMMENTABLE_TYPES = %w[Post].freeze

  validates :commentable_type, inclusion: { in: COMMENTABLE_TYPES }

  with_options presence: true do
    validates :content
  end
end
