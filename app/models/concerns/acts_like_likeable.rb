# frozen_string_literal: true

module ActsLikeLikeable
  extend ActiveSupport::Concern

  included do
    with_options dependent: :destroy do
      has_many :likes, as: :likeable
    end
  end

  def like(user) = likes.find_by(likeable: self, user:)
  def like?(user) = likes.exists?(user:)
end
