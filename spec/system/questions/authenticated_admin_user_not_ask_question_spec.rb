require 'rails_helper'

describe 'Usuário não pode fazer uma pergunta' do
  it 'pois é admin' do
  #Arrange
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      
    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
    lot_item = LotItem.create!(lot: lot, item: item)
  
  #Act
    login_as(user_admin)
    visit root_path
    click_on 'RTX306000'
    click_on 'Faça uma pergunta sobre o lote!'

  #Assert
    expect(page).to have_content 'Usuário admin não pode fazer perguntas!'
  end
end