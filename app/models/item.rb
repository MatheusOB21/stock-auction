class Item < ApplicationRecord
  before_validation :generate_code
  
  validates :code, uniqueness: true
  validates :name, :description, :width, :height, :depth, :weight, :product_category, presence: true
  
  has_one_attached :image


  def item_dimensions
    "#{width} x #{height} x #{depth} cm"
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
  
end
