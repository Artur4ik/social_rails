# frozen_string_literal: true

class User < ApplicationRecord
  WOMAN = 'woman'
  MAN = 'man'

  has_secure_password
  has_one_attached :avatar

  enum :sex, { woman: WOMAN, man: MAN }

  with_options class_name: Relationship.name, dependent: :destroy do
    has_many :followed_users, foreign_key: :follower_id
    has_many :follower_users, foreign_key: :followed_id
  end

  has_many :followed, through: :followed_users, source: :followed
  has_many :followers, through: :follower_users, source: :follower

  with_options dependent: :destroy do
    has_many :likes
    has_many :comments
    has_many :posts
  end

  with_options presence: true, uniqueness: true do
    validates :email
    validates :name
  end

  scope :womans, -> { where(sex: WOMAN) }
  scope :mans, -> { where(sex: MAN) }
  scope :birthdate_today, -> { where(birthdate: Date.current) }

  def feed = Post.where(user: followed)
  def follow?(follower) = followed_users.exists?(followed_id: follower.id)
  def follow!(follower) = followed_users.create!(followed_id: follower.id)
  def unfollow!(follower) = followed_users.find_by(followed_id: follower.id).destroy!
end
