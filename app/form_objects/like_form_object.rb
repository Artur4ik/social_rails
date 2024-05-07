# frozen_string_literal: true

class LikeFormObject
  def initialize(likeable_id:, likeable_type:, user:)
    @likeable_id = likeable_id
    @likeable_type = likeable_type.classify
    @user = user
  end

  def save
    like ? destroy_like : create_like
  end

  def like
    @like ||= user.likes.find_by(likeable_id:, likeable_type:)
  end

  private

  attr_reader :likeable_id, :likeable_type, :user

  def create_like
    @like = user.likes.create(user:, likeable_id:, likeable_type:)
  end

  def destroy_like = like.destroy
end
