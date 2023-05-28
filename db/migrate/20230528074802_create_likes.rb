# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :user
      t.index %i[user_id likeable_id likeable_type], unique: true

      t.timestamps
    end
  end
end
