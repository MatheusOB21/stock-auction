class Lot < ApplicationRecord
  belongs_to :user
  has_one :user_aprovated
  
  has_many :lot_items
  has_many :items, through: :lot_items

  enum :status, pending: 1, aprovated: 3

  validates :code, :start_date, :limit_date, :minimal_difference, :minimal_val, presence: true
  
  validates :code, uniqueness: true
  validates :code, length: {is: 9}
  validate :code_format
  
  validates :limit_date, comparison: { greater_than: :start_date }

  private

  def code_format
    if self.code =~ /[a-zA-Z]{3}[0-9]{6}/
    else
      errors.add(:code, "não está no formato esperado: 3 letras + 6 números")
    end
  end
  
end
