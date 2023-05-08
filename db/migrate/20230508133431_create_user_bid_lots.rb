class CreateUserBidLots < ActiveRecord::Migration[7.0]
  def change
    create_table :user_bid_lots do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lot, null: false, foreign_key: true
      t.integer :bid_amaunt

      t.timestamps
    end
  end
end
