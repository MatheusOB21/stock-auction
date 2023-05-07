class LotItem < ApplicationRecord
  belongs_to :lot
  belongs_to :item
end
