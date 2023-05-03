class AddProductCategoryToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :product_category, :string
  end
end
