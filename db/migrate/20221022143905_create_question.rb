class CreateQuestion < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :body, null: false
      t.references :user, null: true, foreign_key: true
      t.string :slug, null: false

      t.timestamps
    end

    add_index :questions, :slug, unique: true
  end
end
