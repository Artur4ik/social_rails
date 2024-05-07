# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :sex, %w[man woman]

    create_table :users do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :country
      t.string :city
      t.enum :sex, enum_type: :sex
      t.date :birthdate
      t.text :bio

      t.timestamps
    end
  end
end
