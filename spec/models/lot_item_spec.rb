require 'rails_helper'

RSpec.describe LotItem, type: :model do
  describe 'O model tem referência com' do
    it 'lote' do

        result = LotItem.reflect_on_association(:lot).macro

        expect(result).to eq :belongs_to
    end
    it 'usuário' do

        result = LotItem.reflect_on_association(:item).macro

        expect(result).to eq :belongs_to
    end
  end
end
