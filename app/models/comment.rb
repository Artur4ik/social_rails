# frozen_string_literal: true

class Comment < ApplicationRecord
  include ActsLikeLikeable

  belongs_to :user
  belongs_to :post

  with_options presence: true do
    validates :content
  end
end
