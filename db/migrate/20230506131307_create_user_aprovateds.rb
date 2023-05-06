class CreateUserAprovateds < ActiveRecord::Migration[7.0]
  def change
    create_table :user_aprovateds do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_aprovated

      t.timestamps
    end
  end
end
