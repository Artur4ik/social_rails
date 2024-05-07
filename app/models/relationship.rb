# frozen_string_literal: true

class Relationship < ApplicationRecord
  with_options class_name: User.name do
    belongs_to :follower
    belongs_to :followed
  end

  with_options presence: true do
    validates :follower_id
    validates :followed_id
  end
end
