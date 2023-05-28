# frozen_string_literal: true

module Jwt
  class Decode < Base
    def initialize(token)
      @token = token
    end

    def call
      decode_token
    end

    private

    attr_reader :token

    def decode_token
      JWT.decode(token, secret, true, algorithm:).first
    end
  end
end
