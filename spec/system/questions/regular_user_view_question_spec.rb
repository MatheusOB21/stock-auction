require 'rails_helper'

describe 'Usuário regular vê pergunta' do
  
  it 'sem resposta, no detalhes do lote' do
  #Arrange
    user_admin = User.create!(name: "João", email: "joao@leilaodogalpao.com.br", password: "joao_do_leilão", cpf:"50534524079")
    user_regular = User.create!(name: "Katara", email: "katara@gmail.com.br", password: "katara12345", cpf:"09036567017")
      
    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
    lot_item = LotItem.create!(lot: lot, item: item)

    Question.create!(lot: lot, question: "Os itens estão novos?")
  
  #Act
    login_as(user_regular)
    visit root_path
    click_on 'RTX306000'
  #Assert
    expect(page).to have_content 'Os itens estão novos?'
    expect(page).to have_content 'Ainda não respondida'  
  end
  
  it 'com resposta, no detalhes do lote' do
  #Arrange
    user_admin = User.create!(name: "João", email: "joao@leilaodogalpao.com.br", password: "joao_do_leilão", cpf:"50534524079")
    user_regular = User.create!(name: "Katara", email: "katara@gmail.com.br", password: "katara12345", cpf:"09036567017")
      
    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
    lot_item = LotItem.create!(lot: lot, item: item)

    question = Question.create!(lot: lot, question: "Os itens estão novos?")
    Answer.create!(question: question, answer: "Sim, todos estão em ótimo estado", user: user_admin)
  
  #Act
    login_as(user_regular)
    visit root_path
    click_on 'RTX306000'
  #Assert
    expect(page).to have_content 'Os itens estão novos?'
    expect(page).to have_content 'Resposta: Sim, todos estão em ótimo estado'  
  end
end