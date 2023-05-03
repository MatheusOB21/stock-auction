class AddProductCategoryRefToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :product_category, null: false, foreign_key: true
  end
end
