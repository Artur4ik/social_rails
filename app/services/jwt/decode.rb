# frozen_string_literal: true

module Jwt
  class Decode < Base
    def initialize(token)
      @token = token
    end

    def call = JWT.decode(token, secret, true, algorithm:).first

    private

    attr_reader :token
  end
end
