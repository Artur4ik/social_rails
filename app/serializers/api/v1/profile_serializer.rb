# frozen_string_literal: true

module API
  module V1
    class ProfileSerializer < BaseSerializer
      set_type :user

      attributes :email,
                 :name,
                 :sex,
                 :country,
                 :city,
                 :bio

      attribute(:birthdate) { |object| I18n.l(object.birthdate) }
      attribute(:avatar) { |object| object.avatar.url }
    end
  end
end
