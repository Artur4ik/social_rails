# frozen_string_literal: true

module Api
  module V1
    class UserSerializer
      include JSONAPI::Serializer

      attributes :email,
                 :first_name,
                 :last_name,
                 :birthdate,
                 :sex,
                 :country,
                 :city,
                 :created_at,
                 :updated_at
    end
  end
end
