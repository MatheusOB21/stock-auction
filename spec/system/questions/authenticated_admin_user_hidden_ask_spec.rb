require 'rails_helper'

describe 'Usuário admin oculta uma pergunta' do
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX806000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

      Question.create!(lot: lot, question: "Essas merdas desses itens funcionam?")
    
    #Act
      login_as(user_admin)
      visit root_path
      click_on 'Perguntas sem respostas'
      within("#1") do
        click_on 'Ocultar'
      end

    #Assert
      expect(page).to have_content 'Pergunta ocultada com sucesso!'
      expect(page).to have_content 'Status: Oculto'
      expect(page).not_to have_button 'Ocultar'
      expect(Question.last.status).to eq "hidden"
  end

  it 'e ela não deve aparecer para os usuário sem autenticação verem' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

      question = Question.create!(lot: lot, question: "Sempre fui roubado em leilões! Tudo é uma fraude?")
      question.hidden!
    #Act
      visit root_path
      click_on 'RTX306000'
    #Assert
      expect(page).not_to have_content "Sempre fui roubado em leilões! Tudo é uma fraude?"
      expect(page).to have_content "Sem perguntas até o momento"
  end
  
  it 'e ela não deve aparecer para os usuário regulares verem' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

      question = Question.create!(lot: lot, question: "Sempre fui roubado em leilões! Tudo é uma fraude?")
      question.hidden!
    #Act
      login_as(user_regular)
      visit root_path
      click_on 'RTX306000'
    #Assert
      expect(page).not_to have_content "Sempre fui roubado em leilões! Tudo é uma fraude?"
      expect(page).to have_content "Sem perguntas até o momento"
  end

end