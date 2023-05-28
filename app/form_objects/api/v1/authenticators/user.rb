# frozen_string_literal: true

module Api
  module V1
    module Authenticators
      class User
        include ActiveModel::Validations

        validate :check_user_presence
        validate :check_user_password, if: -> { errors.empty? }

        def initialize(email:, password:)
          @email = email
          @password = password
        end

        def valid?
          super

          errors.empty?
        end

        private

        attr_reader :email, :password, :user

        def check_user_presence
          return if (@user = ::User.find_by(email:))

          errors.add(:email, :invalid)
        end

        def check_user_password
          return if user.authenticate(password)

          errors.add(:password, :invalid)
        end
      end
    end
  end
end
