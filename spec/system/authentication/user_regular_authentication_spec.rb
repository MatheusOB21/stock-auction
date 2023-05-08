require 'rails_helper'

describe 'Usuário regular ao crair a conta' do
  it 'não pode usar o mesmo CPF de um usuário admin' do
    #Arrange
      User.create!(name: "Lívia", email: "lívia@leilaodogalpao.com.br", password: "lívia1234", cpf: "14272954091")
    #Act
    visit root_path
    click_on 'Login'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'CPF', with: '14272954091'
    fill_in 'E-mail', with: 'jose@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'admin@1234'
    fill_in 'Confirme sua senha', with: 'admin@1234'
    click_on 'Criar conta'
    #Assert
    expect(current_path).not_to eq root_path
    expect(page).to have_content 'Cpf já está em uso'
  end
  it 'não pode usar o mesmo email de um usuário admin' do
    #Arrange
      User.create!(name: "Lívia", email: "admin@leilaodogalpao.com.br", password: "lívia1234", cpf: "14272954091")
    #Act
    visit root_path
    click_on 'Login'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'CPF', with: '38548644001'
    fill_in 'E-mail', with: 'admin@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'admin@1234'
    fill_in 'Confirme sua senha', with: 'admin@1234'
    click_on 'Criar conta'
    #Assert
    expect(current_path).not_to eq root_path
    expect(page).to have_content 'E-mail já está em uso'
  end
end