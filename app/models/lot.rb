class Lot < ApplicationRecord
  belongs_to :user

  enum :status, pending: 1, aprovated: 3
end
