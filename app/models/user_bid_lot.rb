class UserBidLot < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validate :val_minimal_of_lot
  validate :val_minimal_of_bid

  validates :bid_amount, presence: true

  private

  def val_minimal_of_lot
    if !self.bid_amount.nil? && self.bid_amount <= self.lot.minimal_val
      self.errors.add(:bid_amount, "precisa ser maior que R$#{self.lot.minimal_val}")
    end
  end

  def val_minimal_of_bid
    if !self.lot.user_bid_lots.empty? && !self.bid_amount.nil? && self.bid_amount <= self.lot.user_bid_lots.order(:bid_amount).last.bid_amount + self.lot.minimal_difference
      self.errors.add(:bid_amount, "precisa ser maior que R$#{self.lot.user_bid_lots.order(:bid_amount).last.bid_amount + self.lot.minimal_difference}")
    end
  end

end
