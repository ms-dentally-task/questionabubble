class CreateQuestionResponse < ActiveRecord::Migration[7.0]
  def change
    create_table :question_responses do |t|
      t.text :body
      t.references :question, null: false, foreign_key: true
      t.string :slug
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
