require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'Nome é obrigatório' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: '', phone_number: '11988254174', email: 'joão@email.com', cpf: '97168422014', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('Nome não pode ficar em branco')
    end

    it 'CPF deve ser válido caso inserido' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', phone_number: '11988254174', email: 'joão@email.com', cpf: '9999999999', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('CPF inválido')
    end

    it 'CPF pode ficar vazio' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', phone_number: '11988254174', email: 'joão@email.com', cpf: '', establishment: establishment, user: user)

      expect(order.valid?).to eq(true)
    end

    it 'Telefone ou email é obrigatório' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', cpf: '97168422014', phone_number: '', email: '', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('Pedido deve ter um telefone ou email')
    end

    it 'Telefone deve ser obrigatório quando não tem email' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', phone_number: '11988254174', cpf: '97168422014', establishment: establishment, user: user)
      
      expect(order.valid?).to eq(true)
    end

    it 'Email deve ser obrigatório quando não tem telefone' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', email: 'joão@email.com', cpf: '97168422014', establishment: establishment, user: user)
      
      expect(order.valid?).to eq(true)
    end

    it 'Telefone não deve ter letras' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', email: 'joão@email.com', phone_number: '119882a54174', cpf: '97168422014', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('Telefone deve ter somente números')
    end

    it 'Telefone não pode ser menor que 10 caracteres' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', email: 'joão@email.com', phone_number: '1198824', cpf: '97168422014', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('Telefone é muito curto')
    end

    it 'Telefone não pode ser maior que 11 caracteres' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', email: 'joão@email.com', phone_number: '1198824457895', cpf: '97168422014', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('Telefone é muito longo')
    end

    it 'Email deve ser valido' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: 'Juninho', email: 'joão@email', phone_number: '1198824457895', cpf: '97168422014', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('Email inválido')
    end
  end
end
