# frozen_string_literal: true

class FeedQuery
  def initialize(user:)
    @user = user
  end

  def call
    query
  end

  private

  attr_reader :user

  def query
    {
      posts:
    }
  end

  def posts
    Post.eager_load(:likes, :comments, :user).map do |post|
      {
        user: {
          name: post.user.name,
          avatar: post.user.avatar
        },
        likes: {
          count: post.likes.size,
          liked: post.likes.pluck(:user_id).include?(user.id)
        },
        comments: post.comments,
        location: post.location,
        image: post.image,
        description: post.description,
        id: post.id,
      }
    end
  end
end
