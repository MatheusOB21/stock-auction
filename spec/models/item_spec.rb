require 'rails_helper'

RSpec.describe Item, type: :model do
    describe 'Gera um código aletório de 10 digitos' do
      it 'ao criar um item' do
        #Arrange
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        #Act
          item.save!
        #Assert
          expect(item.code).not_to be_empty
          expect(item.code.length).to eq(10)
      end
      it 'que precisa ser único' do
        #Arrange
          item_1 = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
          item_2 = Item.new(name: 'HB20', description: 'Uma carro verde, veloz e em ótimo estado', weight: 4000, depth: 5000, height: 5500, width: 900, product_category: 'Carro')
        #Act
          item_1.save!
          item_2.save!
        #Assert
          expect(item_1.code).not_to eq(item_2.code)
      end
    end
    describe 'Ao criar um item, o campo' do
      it 'nome não pode ficar em branco' do
        #Arrange
          item = Item.new(name: '', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        #Act
          result = item.valid?
        #Assert
          expect(result).to eq false
      end
      it 'descrição não pode ficar em branco' do
        #Arrange
          item = Item.new(name: 'Ninja 2000', description: '', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        #Act
          result = item.valid?
        #Assert
          expect(result).to eq false
      end
      it 'peso não pode ficar em branco' do
        #Arrange
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: '', depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        #Act
          result = item.valid?
        #Assert
          expect(result).to eq false
      end
      it 'altura não pode ficar em branco' do
        #Arrange
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 0, depth: 1000, height: '', width: 300, product_category: 'Motocicleta')
        #Act
          result = item.valid?
        #Assert
          expect(result).to eq false
      end
      it 'profundidade não pode ficar em branco' do
        #Arrange
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 0, depth: '', height: 1500, width: 300, product_category: 'Motocicleta')
        #Act
          result = item.valid?
        #Assert
          expect(result).to eq false
      end
      it 'largura não pode ficar em branco' do
        #Arrange
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 0, depth: 1000, height: 1500, width: '', product_category: 'Motocicleta')
        #Act
          result = item.valid?
        #Assert
          expect(result).to eq false
      end
    end

end
