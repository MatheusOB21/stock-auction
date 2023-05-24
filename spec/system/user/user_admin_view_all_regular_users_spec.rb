require 'rails_helper'

describe 'Usuário admin visualiza todos os usuários regulares' do
  it 'a partir de um link no menu' do
    user_admin = User.create!(name: "Paulo", email: "paulo@leilaodogalpao.com.br", cpf: '41505837065', password: 'paulo123456789')

    login_as(user_admin)
    visit root_path

    expect(page).to have_link 'Usuários regulares'
  end

  it 'com sucesso' do
    user_admin = User.create!(name: "Paulo", email: "paulo@leilaodogalpao.com.br", cpf: '41505837065', password: 'paulo123456789')
    User.create!(name: "Laura", email: "laura@gmail.com", cpf: '90347825060', password: 'laura123456789')
    User.create!(name: "Marcos", email: "marcos@gmail.com", cpf: '77476573072', password: 'marcos123456789')
    User.create!(name: "Márcio", email: "márcio@gmail.com", cpf: '06053127027', password: 'marcio123456789') 
    User.create!(name: "Livia", email: "livia@gmail.com", cpf: '53129624066', password: 'livia123456789')

    login_as(user_admin)
    visit root_path
    click_on 'Usuários regulares'

    expect(page).to have_content 'Laura'
    expect(page).to have_content '90347825060'
    expect(page).to have_content 'Marcos'
    expect(page).to have_content '77476573072'
    expect(page).to have_content 'Márcio'
    expect(page).to have_content '06053127027'
    expect(page).to have_content 'Livia'
    expect(page).to have_content '53129624066'
  end
  
  it 'e bloqueia um usuário' do
    user_admin = User.create!(name: "Paulo", email: "paulo@leilaodogalpao.com.br", cpf: '41505837065', password: 'paulo123456789')
    User.create!(name: "Laura", email: "laura@gmail.com", cpf: '90347825060', password: 'laura123456789')

    login_as(user_admin)
    visit root_path
    click_on 'Usuários regulares'
    within("#2") do
      click_on 'Bloquear'
    end

    expect(page).to have_content 'Usuário bloqueado com sucesso!'
    expect(page).to have_button 'Desbloquear'
    expect(page).not_to have_button 'Bloquear'
  end
end