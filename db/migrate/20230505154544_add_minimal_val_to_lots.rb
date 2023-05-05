class AddMinimalValToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :minimal_val, :float
  end
end
