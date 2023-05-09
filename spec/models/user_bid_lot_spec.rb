require 'rails_helper'

RSpec.describe UserBidLot, type: :model do
  describe '#val_minimal_of_lot' do
    it 'O valor minimo para um lance precisa ser maior que o valor minimo do lote' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")

        lot = Lot.create!(code: "FRA456345", start_date: 5.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: lot, item: item)

        bid1 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 25)
        bid2 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 100)
      #Act
        result1 = bid1.valid?
        result2 = bid2.valid?
      #Assert
        expect(result1).to eq false
        expect(result2).to eq true
    end
  end
  describe '#val_minimal_of_bid' do
    it 'O valor minimo para um lance precisa ser maior que o último lance' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")

        lot = Lot.create!(code: "FRA456345", start_date: 5.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: lot, item: item)

        bid1 = UserBidLot.create!(user: user_regular, lot: lot, bid_amount: 100)


        bid2 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 101)
        bid3 = UserBidLot.new(user: user_regular, lot: lot, bid_amount: 120)
      #Act
        result1 = bid2.valid?
        result2 = bid3.valid?
      #Assert
        expect(result1).to eq false
        expect(result2).to eq true
    end
  end
end
