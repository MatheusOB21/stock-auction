class AddRefUserAprovatedToLot < ActiveRecord::Migration[7.0]
  def change
    add_reference :lots, :user_aprovated, null: true, foreign_key: true
  end
end
