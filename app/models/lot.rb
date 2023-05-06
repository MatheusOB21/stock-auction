class Lot < ApplicationRecord
  belongs_to :user
  belongs_to :user_aprovated, optional: true

  enum :status, pending: 1, aprovated: 3
end
