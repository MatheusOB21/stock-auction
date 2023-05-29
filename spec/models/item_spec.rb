require 'rails_helper'

RSpec.describe Item, type: :model do
    describe 'Gera um código aletório de 10 dígitos' do
      it 'ao criar um item' do
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

          item.save!

          expect(item.code).not_to be_empty
          expect(item.code.length).to eq(10)
      end
      it 'que precisa ser único' do
          item_1 = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
          item_2 = Item.new(name: 'HB20', description: 'Uma carro verde, veloz e em ótimo estado', weight: 4000, depth: 5000, height: 5500, width: 900, product_category: 'Carro')

          item_1.save!
          item_2.save!

          expect(item_1.code).not_to eq(item_2.code)
      end
    end
    
    describe 'Ao criar um item' do
      it 'o campo nome não pode ficar em branco' do
          item = Item.new(name: '', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

          result = item.valid?

          expect(result).to eq false
      end
      it 'o campo descrição não pode ficar em branco' do
          item = Item.new(name: 'Ninja 2000', description: '', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

          result = item.valid?

          expect(result).to eq false
      end
      it 'o campo peso não pode ficar em branco' do
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: '', depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

          result = item.valid?

          expect(result).to eq false
      end
      it 'o campo altura não pode ficar em branco' do
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 0, depth: 1000, height: '', width: 300, product_category: 'Motocicleta')

          result = item.valid?

          expect(result).to eq false
      end
      it 'o campo profundidade não pode ficar em branco' do
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 0, depth: '', height: 1500, width: 300, product_category: 'Motocicleta')

          result = item.valid?

          expect(result).to eq false
      end
      it 'o campo largura não pode ficar em branco' do
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 0, depth: 1000, height: 1500, width: '', product_category: 'Motocicleta')

          result = item.valid?

          expect(result).to eq false
      end
      it 'o campo modelo do produto não pode ficar em branco' do
          item = Item.new(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 0, depth: 1000, height: 1500, width: 200, product_category: '')

          result = item.valid?

          expect(result).to eq false
      end
    end

    describe '#item_dimensions' do
      it 'devolve as dimensões com centímetros' do
        item = Item.new(name: 'Yamaha 350', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        
        result = item.item_dimensions
        
        expect(result).to eq "300 x 1500 x 1000 cm"
      end
    end

end
