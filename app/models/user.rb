# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :email
  end
end
