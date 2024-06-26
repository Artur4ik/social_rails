# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :location
      t.text :description
      t.references :user

      t.timestamps
    end
  end
end
