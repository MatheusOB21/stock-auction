class ChangeStatusToIntegerLot < ActiveRecord::Migration[7.0]
  def change
    change_column :lots, :status, :integer, default: 1
  end
end
