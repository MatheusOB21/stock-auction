require 'rails_helper'

RSpec.describe UserAprovated, type: :model do
  describe 'tem referencia a' do
    it 'lote' do
      #Arrange

      #Act
        result = UserAprovated.reflect_on_association(:lot).macro
      #Assert
        expect(result).to eq :belongs_to
    end
    it 'usuário' do
      #Arrange

      #Act
        result = UserAprovated.reflect_on_association(:user).macro
      #Assert
        expect(result).to eq :belongs_to
    end
  end
end
