class AddItemsRefToProductCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_categories, :items, null: false, foreign_key: true
  end
end
