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
    it 'do usuário que o aprovou' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")

      lot = Lot.new(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
      lot.user_aprovated = UserAprovated.create!(user: user_admin_2, date_aprovated: Date.today)
    #Act
      lot.save!
    #Assert
      expect(lot.user_aprovated.user_id).to eq user_admin_2.id
      expect(lot.user_aprovated.user_id).not_to eq user_admin.id
    end
  end

  describe 'Código do lote' do
    it 'precisa estar no formato correto' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        
        lot1 = Lot.new(code: "FLAARTYZX", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        lot2 = Lot.new(code: "123RTYZX", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        lot3 = Lot.new(code: "123456789", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        
        lot4 = Lot.new(code: "FLA123456", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
      #Act
        result1 = lot1.valid?
        result2 = lot2.valid?
        result3 = lot3.valid?
        result4 = lot4.valid?
      #Assert
        expect(result1).to eq false
        expect(result2).to eq false
        expect(result3).to eq false
        expect(result4).to eq true
    end
  end
end
