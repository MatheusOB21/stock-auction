require 'rails_helper'

describe 'Usuario admin autenticado' do
  it 'vê as perguntas sem respostas' do
    #Arrange
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
      
    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    lot = Lot.create!(code: "RTX306000", start_date: 5.day.ago, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
    lot_item = LotItem.create!(lot: lot, item: item)

    question = Question.create!(lot: lot, question: "Qual o estado dos itens?")
    question = Question.create!(lot: lot, question: "Qual a procedência dos itens?")
    question = Question.create!(lot: lot, question: "Qual o ano da moto?")
    question = Question.create!(lot: lot, question: "Os items são originais?")
  
  #Act
    login_as(user_admin)
    visit root_path
    click_on 'Perguntas sem respostas'
  #Assert
    expect(current_path).to eq questions_path
    expect(page).to have_content "Qual o estado dos itens?"    
    expect(page).to have_content "Qual a procedência dos itens?"     
    expect(page).to have_content "Qual o ano da moto?"    
    expect(page).to have_content "Os items são originais?"  
  end
end