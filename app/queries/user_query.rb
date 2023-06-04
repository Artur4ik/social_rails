# frozen_string_literal: true

class UserQuery
  def initialize(user:)
    @user = user
  end

  def call
    query
  end

  private

  attr_reader :user

  with_options to: :user do
    delegate :avatar
    delegate :name
    delegate :country
    delegate :city
    delegate :sex
    delegate :birthdate
    delegate :bio
  end

  def query
    {
      user: {
        avatar:,
        name:,
        country:,
        city:,
        sex:,
        birthdate:,
        bio:
      },
      posts: {
        data: posts,
        count: posts.length
      }
    }
  end

  def posts
    @posts ||= user.posts.order(created_at: :desc)
  end
end
