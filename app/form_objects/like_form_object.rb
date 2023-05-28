# frozen_string_literal: true

class LikeFormObject
  def initialize(likeable_id:, likeable_type:, user:)
    @likeable_id = likeable_id
    @likeable_type = likeable_type
    @user = user
  end

  def save
    return unless noteable?

    like ? destroy_like : create_like
  end

  def like
    @like ||= Like.find_by(user:, likeable_id:, likeable_type:)
  end

  private

  attr_reader :likeable_id, :likeable_type, :user

  def create_like
    @like = Like.create(user:, likeable_id:, likeable_type:)
  end

  def destroy_like
    like.destroy
  end

  def noteable?
    likeable_type.safe_constantize&.public_send(:exists?, id: likeable_id)
  end
end
