class UserBidLot < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validate :val_minimal_lot

  private

  def val_minimal_lot
    if self.bid_amount <= self.lot.minimal_val
      self.errors.add(:bid_amount, "precisa ser maior que #{self.lot.minimal_val}")
    end
  end

end
