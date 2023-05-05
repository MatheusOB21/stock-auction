class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :code
      t.date :start_date
      t.date :limit_date
      t.float :minimal_difference
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
