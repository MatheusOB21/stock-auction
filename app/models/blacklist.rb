class Blacklist < ApplicationRecord
  validates :cpf, presence: true
end
