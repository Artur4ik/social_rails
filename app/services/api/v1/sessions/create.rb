# frozen_string_literal: true

module API
  module V1
    module Sessions
      class Create
        def initialize(user)
          @user = user
        end

        def call
          {
            data: {
              token: Jwt::Encode.new(payload).call,
              exp:
            }
          }
        end

        private

        attr_reader :user

        def payload
          {
            user_id: user.id,
            exp: exp.to_i
          }
        end

        def exp
          @exp ||= 12.hours.from_now
        end
      end
    end
  end
end
