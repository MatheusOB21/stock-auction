class AddColumnStatusToUserBidLots < ActiveRecord::Migration[7.0]
  def change
    add_column :user_bid_lots, :status, :integer, default: 0
  end
end
