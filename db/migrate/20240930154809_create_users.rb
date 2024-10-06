class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :signup_token
      t.datetime :token_sent_at
      t.datetime :token_expires_at
      t.boolean :is_active, default: false
      t.boolean :is_admin, default: false

      t.timestamps
    end
  end
end
