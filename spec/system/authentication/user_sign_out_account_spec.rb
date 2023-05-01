require 'rails_helper'

describe 'Usuário realizar log out' do
  it 'com sucesso' do
    #Arrange
      user = User.create!(name: 'Asta', email:'asta@usuario.com', cpf: '79221772080', password: 'senha12345')
    #Act
      visit root_path
      within('nav') do
        click_on 'Login'
      end
      fill_in 'E-mail', with: 'asta@usuario.com'
      fill_in 'Senha', with: 'senha12345'
      within('form') do
        click_on 'Login'
      end
      click_on "Sair"
    #Assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Logout efetuado com sucesso.'
      expect(page).not_to have_content 'Usuário: Asta'
      expect(page).not_to have_button 'Sair'
  end
end