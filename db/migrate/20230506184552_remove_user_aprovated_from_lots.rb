class RemoveUserAprovatedFromLots < ActiveRecord::Migration[7.0]
  def change
    remove_reference :lots, :user_aprovated, null: false, foreign_key: true
  end
end
