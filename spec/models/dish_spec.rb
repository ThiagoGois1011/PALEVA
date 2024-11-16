require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe '#valid?' do
    it 'Nome é obrigatório' do
      owner = create_owner(name: 'Andre')
      establishment = create_establishment(owner, corporate_name: 'Distribuidora Alimentícia Ifood')

      dish = Dish.new(name: '', description: 'Algo descrevendo', establishment: establishment)

      expect(dish.valid?).to eq(false)
      expect(dish.errors.full_messages).to include('Nome não pode ficar em branco')
    end

    it 'Descrição é obrigatório' do
      owner = create_owner(name: 'Andre')
      establishment = create_establishment(owner, corporate_name: 'Distribuidora Alimentícia Ifood')

      dish = Dish.new(name: 'Prato', description: '', establishment: establishment)

      expect(dish.valid?).to eq(false)
      expect(dish.errors.full_messages).to include('Descrição não pode ficar em branco')
    end
  end
end
