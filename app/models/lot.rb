class Lot < ApplicationRecord
  belongs_to :user
  has_one :user_aprovated
  
  has_many :lot_items
  has_many :items, through: :lot_items

  has_many :user_bid_lots

  enum :status, pending: 1, aprovated: 3, closed: 5, canceled: 7

  validates :code, :start_date, :limit_date, :minimal_difference, :minimal_val, presence: true
  validates :code, uniqueness: true
  validates :code, length: {is: 9}

  validates :limit_date, comparison: { greater_than: :start_date }
  
  validate :code_format
  
  def available_for_bid
    self.start_date <= Date.today && self.limit_date >= Date.today && self.status == 'aprovated' ? true : false
  end

  def finished_bids
    self.limit_date < Date.today ? true : false
  end

  def last_bid
    self.user_bid_lots.order(:bid_amount).last
  end

  private

  def code_format
    if self.code =~ /[a-zA-Z]{3}[0-9]{6}/
    else
      errors.add(:code, "não está no formato esperado: 3 letras + 6 números")
    end
  end
  
end
