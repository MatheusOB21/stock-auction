require 'rails_helper'

RSpec.describe UserAprovated, type: :model do
  describe 'O model tem referencia a' do
    it 'lote' do
        result = UserAprovated.reflect_on_association(:lot).macro

        expect(result).to eq :belongs_to
    end
    it 'usuário' do
        result = UserAprovated.reflect_on_association(:user).macro

        expect(result).to eq :belongs_to
    end
  end
  
  describe '#user_different?' do
    it 'Retorna true se o usuario que aprova é diferente do que criou' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      LotItem.create!(lot: lot, item: item)

      result = UserAprovated.new(lot: lot, user: user_admin_2, date_aprovated: Date.today)
      
      expect(result.valid?).to eq true
    end
    it 'Retorna false se o usuario que aprova é igual ao que criou' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      LotItem.create!(lot: lot, item: item)

      result = UserAprovated.new(lot: lot, user: user_admin, date_aprovated: Date.today)
      
      expect(result.valid?).to eq false
      # expect(result.valid?.errors.full_messages).to have_content 
    end
  end
end
