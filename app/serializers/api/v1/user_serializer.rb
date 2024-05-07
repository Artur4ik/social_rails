# frozen_string_literal: true

module API
  module V1
    class UserSerializer < BaseSerializer
      has_many :posts

      attributes :email,
                 :name,
                 :birthdate,
                 :sex,
                 :country,
                 :city,
                 :bio

      attribute(:avatar) { |object| object.avatar.url }
    end
  end
end
