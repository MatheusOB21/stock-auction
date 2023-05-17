require 'rails_helper'

describe 'Usuario regular faz uma pergunta' do
  
  it 'apenas estando autenticado' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    
    #Act
      visit root_path
      click_on 'RTX306000'
      click_on 'Faça uma pergunta sobre o lote!'
    #Assert
      expect(current_path).to eq new_user_session_path

  end
  
  it 'a partir dos detalhes do lote' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    
    #Act
      login_as(user_regular)
      visit root_path
      click_on 'RTX306000'
      click_on 'Faça uma pergunta sobre o lote!'
    #Assert
      expect(current_path).to eq new_lot_question_path(lot.id)
      expect(page).to have_field 'Pergunta'
      expect(page).to have_button 'Enviar'
      expect(page).to have_link 'Voltar ao lote'     
  end
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    
    #Act
      login_as(user_regular)
      visit root_path
      click_on 'RTX306000'
      click_on 'Faça uma pergunta sobre o lote!'
      fill_in 'Pergunta', with: 'Qual o estado dos itens presente no lote?'
      click_on 'Enviar'
    #Assert
      expect(current_path).to eq lot_path(lot.id)
      expect(Question.last.question).to eq 'Qual o estado dos itens presente no lote?'
  end

  it 'com sucesso, e vê a pergunta no lote' do
  #Arrange
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
      
    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
    lot_item = LotItem.create!(lot: lot, item: item)
  
  #Act
    login_as(user_regular)
    visit root_path
    click_on 'RTX306000'
    click_on 'Faça uma pergunta sobre o lote!'
    fill_in 'Pergunta', with: 'Qual o estado dos itens presente no lote?'
    click_on 'Enviar'
  #Assert
    expect(current_path).to eq lot_path(lot.id)
    expect(page).to have_content 'Perguntas sobre o lote'    
    expect(page).to have_content 'Dúvidas dos usuário:'    
    expect(page).to have_content 'Qual o estado dos itens presente no lote?'    
  end
  
  it 'sem sucesso, pois deixou  o campo em branco' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    
    #Act
      login_as(user_regular)
      visit root_path
      click_on 'RTX306000'
      click_on 'Faça uma pergunta sobre o lote!'
      fill_in 'Pergunta', with: ''
      click_on 'Enviar'
    #Assert
      expect(page).to have_content 'Pergunta não pode ficar em branco'   
      expect(page).to have_content 'Sua pergunta não foi registrada!'   
  end
end