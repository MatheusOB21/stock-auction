class Item < ApplicationRecord
  before_validation :generate_code
  validates :code, uniqueness: true
  has_one_attached :image


  def item_dimensions
    "#{width} x #{height} x #{depth} cm"
  end
  
  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
  
end
