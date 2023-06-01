class UserBidLot < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validate :val_minimal_of_lot, on: :create
  validate :val_minimal_of_bid, on: :create
  validate :user_is_admin, on: :create

  validates :bid_amount, presence: true

  enum :status, bid: 0, loser: 1, won: 2

  private

  def user_is_admin
    if self.user.is_admin
      self.errors.add(:user, "administrador não pode dar lance!")
    end
  end

  def val_minimal_of_lot
    if !self.bid_amount.nil? && self.bid_amount <= self.lot.minimal_val
      self.errors.add(:bid_amount, "precisa ser maior que o valor mínimo do lote")
    end
  end

  def val_minimal_of_bid
    if !self.lot.user_bid_lots.empty? && !self.bid_amount.nil? && self.bid_amount < self.lot.user_bid_lots.order(:bid_amount).last.bid_amount + self.lot.minimal_difference
      self.errors.add(:bid_amount, "precisa ser maior que R$#{self.lot.user_bid_lots.order(:bid_amount).last.bid_amount + self.lot.minimal_difference}")
    end
  end

end
