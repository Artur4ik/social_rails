# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  with_options dependent: :destroy do
    has_many :likes
    has_many :comments
    has_many :posts
  end

  with_options presence: true do
    validates :email, uniqueness: true
  end
end
