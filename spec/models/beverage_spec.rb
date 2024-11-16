require 'rails_helper'

RSpec.describe Beverage, type: :model do
  describe '#valid?' do
    it 'Nome é obrigatório' do
      owner = create_owner(name: 'Andre')
      establishment = create_establishment(owner, corporate_name: 'Distribuidora Alimentícia Ifood')

      beverage = Beverage.new(name: '', description: 'Algo descrevendo', establishment: establishment)

      expect(beverage.valid?).to eq(false)
      expect(beverage.errors.full_messages).to include('Nome não pode ficar em branco')
    end

    it 'Descrição é obrigatório' do
      owner = create_owner(name: 'Andre')
      establishment = create_establishment(owner, corporate_name: 'Distribuidora Alimentícia Ifood')

      beverage = Beverage.new(name: 'Bebida', description: '', establishment: establishment)

      expect(beverage.valid?).to eq(false)
      expect(beverage.errors.full_messages).to include('Descrição não pode ficar em branco')
    end
  end
end
