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

    context 'Valor deve ser único:' do
      it 'CNPJ' do
        user_1 = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
        Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                              restration_number: '17659527000125', full_address: 'Av Presindete Cabral', 
                              phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
        user_2 = User.create!(name: 'Thiago', last_name: 'Gois', cpf: CPF.generate, email: 'thiago@email.com', password: 'password1234')
        establishment_2 = Establishment.new(corporate_name: 'Distribuidora Alimentícia MC Lanches', brand_name: 'MC Lanches', 
                                          restration_number: '17659527000125', full_address: 'Av São Paulo', 
                                          phone_number: '11981871423', email: 'contato@mclanches.com', user: user_2)
  
        expect(establishment_2.valid?).to be(false)
      end

      it 'Email' do
        user_1 = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
        Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                              restration_number: '17659527000125', full_address: 'Av Presindete Cabral', 
                              phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
        user_2 = User.create!(name: 'Thiago', last_name: 'Gois', cpf: CPF.generate, email: 'thiago@email.com', password: 'password1234')
        establishment_2 = Establishment.new(corporate_name: 'Distribuidora Alimentícia MC Lanches', brand_name: 'MC Lanches', 
                                          restration_number: '02399570000121', full_address: 'Av São Paulo', 
                                          phone_number: '11981871423', email: 'contato@ifood.com', user: user_2)
  
        expect(establishment_2.valid?).to be(false)
      end

      it 'Telefone' do
        user_1 = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
        Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                              restration_number: '17659527000125', full_address: 'Av Presindete Cabral', 
                              phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
        user_2 = User.create!(name: 'Thiago', last_name: 'Gois', cpf: CPF.generate, email: 'thiago@email.com', password: 'password1234')
        establishment_2 = Establishment.new(corporate_name: 'Distribuidora Alimentícia MC Lanches', brand_name: 'MC Lanches', 
                                          restration_number: '02399570000121', full_address: 'Av São Paulo', 
                                          phone_number: '11981545874', email: 'contato@mclanches.com', user: user_2)
  
        expect(establishment_2.valid?).to be(false)
      end
    end
  end
end
