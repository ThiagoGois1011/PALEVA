require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe '#valid?' do
    it 'Nome é obrigatório' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
      discount = Discount.new(establishment: establishment, name: '', start_date: '2024-11-21', end_date: '2024-11-22',
                              discount_percentage: 10)

      expect(discount.valid?).to eq(false)
      expect(discount.errors.full_messages).to include('Nome não pode ficar em branco')
    end

    it 'Estabelecimento é obrigatório' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
      discount = Discount.new(name: 'Miojão Premium', start_date: '2024-11-21', end_date: '2024-11-22',
                              discount_percentage: 10)

      expect(discount.valid?).to eq(false)
      expect(discount.errors.full_messages).to include('Estabelecimento é obrigatório(a)')
    end

    it 'Data Inicial é obrigatório' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
      discount = Discount.new(establishment: establishment, name: 'Miojão Premium', start_date: '', end_date: '2024-11-22',
                              discount_percentage: 10)

      expect(discount.valid?).to eq(false)
      expect(discount.errors.full_messages).to include('Data de Início não pode ficar em branco')
    end

    it 'Data Final é obrigatório' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
      discount = Discount.new(establishment: establishment, name: 'Miojão Premium', start_date: '2024-11-21', end_date: '',
                              discount_percentage: 10)

      expect(discount.valid?).to eq(false)
      expect(discount.errors.full_messages).to include('Data Final não pode ficar em branco')
    end

    it 'Porcentagem do desconto é obrigatório' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
      discount = Discount.new(establishment: establishment, name: 'Miojão Premium', start_date: '2024-11-21', end_date: '2024-11-22')

      expect(discount.valid?).to eq(false)
      expect(discount.errors.full_messages).to include('Porcentagem do Desconto não pode ficar em branco')
    end

    it 'Data final não pode ser menor que a data de início' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
      discount = Discount.new(establishment: establishment, name: 'Miojão Premium', start_date: '2024-11-22', end_date: '2024-11-21',
                              discount_percentage: 10)

      expect(discount.valid?).to eq(false)
      expect(discount.errors.full_messages).to include('Data Final não pode ser menor que a data de início.')
    end


  end

  describe '#valid_date' do
  it 'Data dentro da validade' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
    discount = Discount.new(establishment: establishment, name: 'Miojão Premium', start_date: '2024-11-21', end_date: '2024-11-25',
                            discount_percentage: 10)

    expect(discount.valid_date(Date.new(2024, 11, 21))).to eq(true)
  end

  it 'Data fora da validade' do
    user = create_owner(name: 'Andre')
    establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
    discount = Discount.new(establishment: establishment, name: 'Miojão Premium', start_date: '2024-11-21', end_date: '2024-11-25',
                            discount_percentage: 10)

    expect(discount.valid_date(Date.new(2024, 11, 26))).to eq(false)
  end
  end
end
