require 'rails_helper'

RSpec.describe User, type: :model do
    describe '#cpf_valid?' do
      it 'Verdadeiro caso o CPF seja válido' do
        user1 = User.new(name: 'Matheus', email: 'matheus@email.com', password: 'senha1234', cpf: '42177771080')
        user2 = User.new(name: 'André', email: 'andré@email.com', password: 'senha12345', cpf: '11665475315')
        #Act

        #Assert
        expect(user1.valid?).to eq true
        expect(user2.valid?).to eq true
      end
      it 'Falso caso o CPF seja inválido' do
        #Arrange
        user1 = User.new(name: 'Joao', email: 'joao@email.com', password: 'senha12345', cpf: '12345678911')
        user2 = User.new(name: 'Maria', email: 'maria@email.com', password: 'senha12345', cpf: '678345890231')
        #Act

        #Assert
        expect(user1.valid?).to eq false
        expect(user2.valid?).to eq false
      end
      it 'Falso caso CPF seja menor do que esperado' do
        #Arrange
        user1 = User.new(name: 'Joao', email: 'joao@email.com', password: 'senha12345', cpf: '12345')
        user2 = User.new(name: 'Maria', email: 'maria@email.com', password: 'senha12345', cpf: '67834')
        #Act

        #Assert
        expect(user1.valid?).to eq false
        expect(user2.valid?).to eq false
      end
    end

    describe "#email_admin" do
      it 'Verdadeiro caso o email seja admin' do
        #Arrange
        user1 = User.new(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'senha12345', cpf: '86397074056')
        user2 = User.new(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'senha12345', cpf: '15937850033')
        #Act
        
        #Assert
        expect(user1.is_admin).to eq true
        expect(user2.is_admin).to eq true
      end
      it 'Faslo caso o email não seja admin' do
        #Arrange
        user1 = User.new(name: 'Joao', email: 'leilaodogalpao@email.com.br', password: 'senha12345', cpf: '86397074056')
        user2 = User.new(name: 'Maria', email: 'maria@galpaoleilao.com.br', password: 'senha12345', cpf: '15937850033')
        #Act
        
        #Assert
        expect(user1.is_admin).to eq false
        expect(user2.is_admin).to eq false
      end
    end
end
