# frozen_string_literal: true

module API
  module V1
    class BaseSerializer
      include JSONAPI::Serializer

      set_key_transform :camel_lower

      attribute(:created_at_human) { |object| I18n.l(object.created_at, format: :long) }
      attribute(:created_at)
    end
  end
end
