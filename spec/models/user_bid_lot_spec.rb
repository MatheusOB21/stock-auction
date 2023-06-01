require 'rails_helper'

RSpec.describe UserBidLot, type: :model do
  
  describe 'O model tem referência a' do
    it 'lote' do

        result = UserBidLot.reflect_on_association(:lot).macro

        expect(result).to eq :belongs_to
    end
    it 'usuário' do

        result = UserBidLot.reflect_on_association(:user).macro

        expect(result).to eq :belongs_to
    end
  end
  
  describe '#val_minimal_of_lot' do
    it 'O valor minimo de um lance precisa ser maior que o valor minimo do lote' do
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
        lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: lot, item: item)
        bid1 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 25)
        bid2 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 100)

        result1 = bid1.valid?
        result2 = bid2.valid?

        expect(result1).to eq false
        expect(result2).to eq true
    end
  end
  
  describe '#val_minimal_of_bid' do
    it 'O valor minimo de um lance precisa ser maior que o último lance' do
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
        lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: lot, item: item)
        bid1 = UserBidLot.create!(user: user_regular, lot: lot, bid_amount: 100)
        bid2 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 101)
        bid3 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 120)

        result1 = bid2.valid?
        result2 = bid3.valid?

        expect(result1).to eq false
        expect(result2).to eq true
    end
  end

  describe '#user_is_admin' do
    it 'Retorna true se o usuário que está fazendo um lance não é administrador' do
      user_admin = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")
      user_regular = User.create!(name: "Leandro", email: "leandro@gmail.com.br", password: "leandro123", cpf: "63254697049")
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

      result = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 1000)
      expect(result.valid?).to eq true
    end
    it 'Retorna false se o usuário que está fazendo um lance é administrador' do
      user_admin = User.create!(name: "Leandro", email: "leandro@leilaodogalpao.com.br", password: "leandro123", cpf: "63254697049")
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

      result = UserBidLot.new(user: user_admin, lot: lot, bid_amount: 1000)
      expect(result.valid?).to eq false
    end
  end
  
  describe 'O valor do lance' do
    it 'não pode estar em branco' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: lot, item: item)
      bid1 = UserBidLot.new(user: user_regular, lot: lot)
      bid2 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 100)

      result1 = bid1.valid?
      result2 = bid2.valid?

      expect(result1).to eq false
      expect(result2).to eq true      
    end
  end

end
