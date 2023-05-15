class Question < ApplicationRecord
  belongs_to :lot

  enum :status, show: 0, hidden: 1
end
