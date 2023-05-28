# frozen_string_literal: true

module Jwt
  class Encode < Base
    def initialize(payload)
      @payload = payload
    end

    def call
      encode_token
    end

    private

    attr_reader :payload

    def encode_token
      JWT.encode(payload, secret, algorithm)
    end
  end
end
