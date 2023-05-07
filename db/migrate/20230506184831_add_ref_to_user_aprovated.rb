class AddRefToUserAprovated < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_aprovateds, :lot, null: true, foreign_key: true
  end
end
