# frozen_string_literal: true

class Post < ApplicationRecord
  include ActsLikeLikeable

  has_one_attached :image

  belongs_to :user

  with_options presence: true do
    validates :image
  end

  with_options dependent: :destroy do
    has_many :comments
  end
end
