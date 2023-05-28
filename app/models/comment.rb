# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  with_options presence: true do
    validates :content
  end

  with_options dependent: :destroy do
    has_many :likes, as: :likeable
  end
end
