class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :status, default: 0
      t.references :lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
