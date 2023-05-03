class RemoveProductCategoryRefToItems < ActiveRecord::Migration[7.0]
  def change
    remove_reference :items, :product_category, null: false, foreign_key: true
  end
end
