# frozen_string_literal: true

def user_base_attributes
  {
    country: FFaker::Address.country,
    city: FFaker::Address.city,
    birthdate: FFaker::Time.date,
    bio: FFaker::Lorem.sentence,
    password: '123',
    sex: User.sexes.keys.sample,
    avatar: ActionDispatch::Http::UploadedFile.new(
      tempfile: Rails.root.join("db/seeds/avatars/#{(1..4).to_a.sample}.jpg"),
      filename: 'avatar.jpg',
      content_type: 'image/jpeg'
    )
  }
end

def post_base_attributes
  {
    location: FFaker::Address.street_address,
    description: FFaker::Lorem.sentence,
    image: ActionDispatch::Http::UploadedFile.new(
      tempfile: Rails.root.join("db/seeds/images/#{(1..9).to_a.sample}.jpg"),
      filename: 'avatar.jpg',
      content_type: 'image/jpeg'
    )
  }
end

def comment_base_attributes
  {
    user_id: User.pluck(:id).sample,
    content: FFaker::Lorem.sentence
  }
end

def like_base_attributes(likeable)
  already_liked_user_ids = likeable.likes.pluck(:user_id)

  {
    user_id: User.where.not(id: already_liked_user_ids).pluck(:id).sample
  }
end

def random(range) = range.to_a.sample

User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

(1..5).each do |n|
  User.create!(
    **user_base_attributes,
    name: "user_#{n}",
    email: "user#{n}@test.com"
  )
end

User.find_each do |user|
  5.times { user.posts.create!(**post_base_attributes) }
end

Post.find_each do |post|
  random(1..9).times { post.comments.create!(**comment_base_attributes) }
  random(0..4).times { post.likes.create!(**like_base_attributes(post)) }
end

Comment.find_each do |comment|
  random(0..4).times { comment.likes.create!(**like_base_attributes(comment)) }
end
