require 'rails_helper'

describe 'Usuário autenticado favorita um lote' do
  
  it 'a partir do botão nos detalhes do lote' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      login_as(user)
      visit root_path
      click_on 'ZTZ456789'
    #Assert
      expect(page).to have_button 'Favoritar'
  end
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      login_as(user)
      visit root_path
      click_on 'ZTZ456789'
      click_on 'Favoritar'
    #Assert
      expect(page).to have_content "Lote favoritado!"
      expect(user.favorites.last.lot_id).to eq lot.id
  end
  
  it 'com sucesso, e não pode favoritar de novo' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      login_as(user)
      visit root_path
      click_on 'ZTZ456789'
      click_on 'Favoritar'
    #Assert
      expect(page).not_to have_button "Favoritar"
      expect(page).to have_button "Desfavoritar"
  end
  
  it 'e desfavorita depois' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      login_as(user)
      visit root_path
      click_on 'ZTZ456789'
      click_on 'Favoritar'
      click_on 'Desfavoritar'
    #Assert
      expect(page).not_to have_button "Desfavoritar"
      expect(page).to have_button "Favoritar"
      expect(user.favorites.empty?).to eq true
  end

end