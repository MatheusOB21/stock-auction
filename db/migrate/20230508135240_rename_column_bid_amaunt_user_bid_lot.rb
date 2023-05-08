class RenameColumnBidAmauntUserBidLot < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_bid_lots, :bid_amaunt, :bid_amount
  end
end
