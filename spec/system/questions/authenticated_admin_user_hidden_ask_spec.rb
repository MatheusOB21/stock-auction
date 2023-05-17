require 'rails_helper'

describe 'Usuário admin oculta uma pergunta' do
  it 'com sucesso' do
  #Arrange
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")

    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
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
    expect(Question.last.status).to eq "hidden"
  end
end