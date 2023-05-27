# frozen_string_literal: true

module Api
  module V1
    class UsersSerializer
      include JSONAPI::Serializer

      attributes :email, :first_name, :last_name
    end
  end
end
