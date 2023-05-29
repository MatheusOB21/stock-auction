require 'rails_helper'

RSpec.describe UserAprovated, type: :model do
  describe 'O model tem referencia a' do
    it 'lote' do

        result = UserAprovated.reflect_on_association(:lot).macro

        expect(result).to eq :belongs_to
    end
    it 'usuário' do

        result = UserAprovated.reflect_on_association(:user).macro

        expect(result).to eq :belongs_to
    end
  end
end
