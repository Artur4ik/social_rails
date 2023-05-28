# frozen_string_literal: true

module Jwt
  class Base
    private

    def algorithm
      Rails.application.secrets.jwt_token_algorithm || 'HS256'
    end

    def secret
      Rails.application.secrets.jwt_token_secret_key || 'secret'
    end
  end
end
