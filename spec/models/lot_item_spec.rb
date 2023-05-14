require 'rails_helper'

RSpec.describe LotItem, type: :model do
  describe 'tem referencia a' do
    it 'lote' do
      #Arrange

      #Act
        result = LotItem.reflect_on_association(:lot).macro
      #Assert
        expect(result).to eq :belongs_to
    end
    it 'usuário' do
      #Arrange

      #Act
        result = LotItem.reflect_on_association(:item).macro
      #Assert
        expect(result).to eq :belongs_to
    end
  end
end
