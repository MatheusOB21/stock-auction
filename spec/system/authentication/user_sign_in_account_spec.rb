require 'rails_helper'

describe 'Usuário consegue' do
  it 've o formulario de login' do
    #Arrange
    
    #Act
      visit root_path
      within('nav') do
        click_on 'Login'
      end
    #Assert
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      within('form') do
        expect(page).to have_button 'Login'
      end
  end
  it 'fazer login com sucesso' do
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
    #Assert
      expect(page).to have_content 'Login efetuado com sucesso.'
      expect(page).to have_content 'Usuário: Asta'
      expect(page).to have_button 'Sair'
  end
  it 'informar dados de login inválidos' do
    #Arrange
      user = User.create!(name: 'Asta', email:'asta@usuario.com', cpf: '79221772080', password: 'senha12345')
    #Act
      visit root_path
      within('nav') do
        click_on 'Login'
      end
      fill_in 'E-mail', with: 'asta@usuario.com'
      fill_in 'Senha', with: 'senha12345789'
      within('form') do
        click_on 'Login'
      end
    #Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'E-mail ou senha inválidos.'
  end
end