# frozen_string_literal: true

module Jwt
  class Encode < Base
    def initialize(payload)
      @payload = payload
    end

    def call = JWT.encode(payload, secret, algorithm)

    private

    attr_reader :payload
  end
end
