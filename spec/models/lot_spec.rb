require 'rails_helper'

RSpec.describe Lot, type: :model do
  describe 'Lote tem a informação' do
    it 'do usuário que o criou' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")

      lot = Lot.new(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
    #Act
      lot.save!
    #Assert
      expect(lot.user_id).to eq user_admin.id
      expect(lot.user_id).not_to eq user_admin_2.id
    end
  end
end
