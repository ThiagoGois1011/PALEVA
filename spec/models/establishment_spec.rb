require 'rails_helper'

RSpec.describe Establishment, type: :model do
  describe '#valid?' do
    context 'Campo Vazio:' do
      it 'Nome Fantaria é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: '', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Razão Social é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: '', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'CNPJ é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Endereço é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: '', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Telefone é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Email é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: '',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Código é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Usuário é obrigatório' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '45668')
  
        expect(e.valid?).to be(false)
      end
    end

    


    context 'Validação de Dados:' do
      it 'Telefone tem que ter o tamanho de 10 ou 11' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '119815485', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'CNPJ tem que ser válido' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '999999',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Email tem que ser válido' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
  
      it 'Código deve ter 6 caracteres' do
        user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
  
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '52464654654654',
                          full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                          code: '45668', user_id: user.id)
  
        expect(e.valid?).to be(false)
      end
    end
  end
end
