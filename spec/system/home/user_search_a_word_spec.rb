require 'rails_helper'

describe 'Usuário faz uma pesquisa de um lote' do

  it 'a partir da tela inicial' do
    #Arrange

    #Act
      visit root_path
      
    #Assert
      expect(page).to have_field("query")  
      expect(page).to have_button 'Buscar'   
  end
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
    #Act
      visit root_path
      fill_in 'query', with: "FRA"
      click_on 'Buscar'
    #Assert
      expect(page).to have_content "Resultados para: FRA"
      expect(page).to have_content "FRA456345"
  end
  
  it 'com sucesso, ao informar um nome do item que está no lote' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      
      lot_item = LotItem.create!(lot: lot, item: item)

    #Act
      visit root_path
      fill_in 'query', with: "NINJA"
      click_on 'Buscar'
    #Assert
      expect(page).to have_content "Resultados para: NINJA"
      expect(page).to have_content "FRA456345"
  end
  
  it 'e não mostra resultados duplicados' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FER456345", start_date: Date.today, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      item = Item.create!(name: 'Ferrari', description: 'Um carro vermelho, veloz e esportivo', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Automóvel')
      
      lot_item = LotItem.create!(lot: lot, item: item)

    #Act
      visit root_path
      fill_in 'query', with: "FER"
      click_on 'Buscar'
    #Assert
      expect(page).to have_content "Resultados para: FER"
      expect(page).to have_content("FER456345", count: 1)
  end

  it 'sem sucesso, pois não tem lotes com o código infomado' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
    #Act
      visit root_path
      fill_in 'query', with: "ASD"
      click_on 'Buscar'
    #Assert
      expect(page).to have_content "Nenhum resultado para: ASD"
  end

end