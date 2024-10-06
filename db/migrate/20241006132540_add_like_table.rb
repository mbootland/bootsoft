class AddLikeTable < ActiveRecord::Migration[7.0]
  def up
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
  end

  def down
    drop_table :likes
  end
end
