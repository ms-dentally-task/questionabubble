class CreateVote < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :voteable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :votes, [:user_id, :voteable_id, :voteable_type], unique: true
  end
end
