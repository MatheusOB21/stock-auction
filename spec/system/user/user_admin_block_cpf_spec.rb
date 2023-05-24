require 'rails_helper'

describe 'Usuário admin bloqueia um CPF' do

  it 'a partir do link' do
    user_admin = User.create!(name: "Paulo", email: "paulo@leilaodogalpao.com.br", cpf: '41505837065', password: 'paulo123456789')
    user = User.create!(name: "Laura", email: "laura@gmail.com", cpf: '90347825060', password: 'laura123456789')

    login_as(user_admin)
    visit root_path
    click_on 'Usuários regulares'
    
    expect(page).to have_content 'Bloqueio de CPF'

  end

  it 'com sucesso' do
    user_admin = User.create!(name: "Paulo", email: "paulo@leilaodogalpao.com.br", cpf: '41505837065', password: 'paulo123456789')
    user = User.create!(name: "Laura", email: "laura@gmail.com", cpf: '90347825060', password: 'laura123456789')

    login_as(user_admin)
    visit root_path
    click_on 'Usuários regulares'
    click_on 'Bloqueio de CPF'
    fill_in 'CPF', with: '90347825060'
    click_on 'Enviar'

    expect(Blacklist.last.cpf).to eq '90347825060'
  end

  it  'sem sucesso, pois informa um CPF em branco' do
    user_admin = User.create!(name: "Paulo", email: "paulo@leilaodogalpao.com.br", cpf: '41505837065', password: 'paulo123456789')
    user = User.create!(name: "Laura", email: "laura@gmail.com", cpf: '90347825060', password: 'laura123456789')

    login_as(user_admin)
    visit root_path
    click_on 'Usuários regulares'
    click_on 'Bloqueio de CPF'
    fill_in 'CPF', with: '50545678910'
    click_on 'Enviar'

    expect(page).to have_content 'CPF é inválido'
  end

end