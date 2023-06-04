# frozen_string_literal: true

module Api
  module V1
    class UserSerializer
      include JSONAPI::Serializer

      attributes :email,
                 :name,
                 :birthdate,
                 :avatar,
                 :sex,
                 :country,
                 :city,
                 :bio,
                 :created_at,
                 :updated_at
    end
  end
end
