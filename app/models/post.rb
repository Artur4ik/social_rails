# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  with_options dependent: :destroy do
    has_many :comments
    has_many :likes, as: :likeable
  end
end
