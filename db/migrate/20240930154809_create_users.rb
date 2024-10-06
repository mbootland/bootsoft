# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :confirmation_token
      t.datetime :confirmation_sent_at
      t.boolean :is_active, default: false
      t.boolean :is_admin, default: false

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
