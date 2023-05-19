require 'rails_helper'

describe 'Usuário faz uma pesquisa' do
  it 'a partir da tela inicial' do
    #Arrange

    #Act
      visit root_path
      
    #Assert
      expect(page).to have_field("query")  
      expect(page).to have_button 'Buscar'   
  end
  it 'de um lote, com sucesso' do
  #Arrange
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
  #Act
    visit root_path
    fill_in 'query', with: "FRA"
    click_on 'Buscar'
  #Assert
    expect(page).to have_content "FRA456345"
  end
end