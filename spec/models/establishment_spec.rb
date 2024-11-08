require 'rails_helper'

RSpec.describe Establishment, type: :model do
  describe '#valid?' do
    context 'Campo Vazio:' do
      it 'Nome Fantaria é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: '', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user: user)
                   
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Nome Fantasia não pode ficar em branco')
      end
  
      it 'Razão Social é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: '', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Razão Social não pode ficar em branco')
      end
  
      it 'CNPJ é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('CNPJ não pode ficar em branco')
      end
  
      it 'Endereço é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: '', phone_number: '11981546985', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Endereço não pode ficar em branco')
      end
  
      it 'Telefone é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Telefone não pode ficar em branco')
      end
  
      it 'Email é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: '', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Email não pode ficar em branco')
      end
  
      it 'Código é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(true)
      end
  
      it 'Usuário é obrigatório' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com')
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Usuário não pode ficar em branco')
      end
    end

    
    context 'Validação de Dados:' do
      it 'Telefone não pode ter o tamanho menor que 10' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '119815485', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Telefone é muito curto')
      end

      it 'Telefone não pode ter o tamanho maior que 11' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136', 
                              full_address: 'Av Presidente Medice', phone_number: '1198154858754', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Telefone é muito longo')
      end

      it 'Telefone não pode ter letras' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '119815485as', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Telefone deve ter somente números')
      end

      it 'Telefone não pode ter simbolos' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '(11) 98154-8548', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Telefone deve ter somente números')
      end
  
      it 'CNPJ tem que ser válido' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '999999',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('CNPJ inválido')
      end
  
      it 'Email tem que ser válido' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood',user: user)
  
        expect(e.valid?).to be(false)
        expect(e.errors.full_messages).to include('Email inválido')
      end
  
      it 'Código deve ter 6 caracteres' do
        user = create_owner(name: 'Thiago')
        e = Establishment.new(corporate_name: 'Ifood Distribuidora Alimentícia', brand_name: 'Ifood', restration_number: '39823425000136',
                              full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user: user)
  
        expect(e.valid?).to be(true)
        expect(e.code.length).to eq(6)
      end
    end

    context 'Valor deve ser único:' do
      it 'CNPJ' do
        user_1 = create_owner(name: 'Andre')
        Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                              restration_number: '17659527000125', full_address: 'Av Presindete Cabral', 
                              phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
        user_2 = create_secondary_owner(name: 'Thiago')
        establishment_2 = Establishment.new(corporate_name: 'Distribuidora Alimentícia MC Lanches', brand_name: 'MC Lanches', 
                                          restration_number: '17659527000125', full_address: 'Av São Paulo', 
                                          phone_number: '11981871423', email: 'contato@mclanches.com', user: user_2)
  
        expect(establishment_2.valid?).to be(false)
        expect(establishment_2.errors.full_messages).to include('CNPJ já está em uso')
      end

      it 'Email' do
        user_1 = create_owner(name: 'Andre')
        Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                              restration_number: '17659527000125', full_address: 'Av Presindete Cabral', 
                              phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
        user_2 = create_secondary_owner(name: 'Thiago')
        establishment_2 = Establishment.new(corporate_name: 'Distribuidora Alimentícia MC Lanches', brand_name: 'MC Lanches', 
                                          restration_number: '02399570000121', full_address: 'Av São Paulo', 
                                          phone_number: '11981871423', email: 'contato@ifood.com', user: user_2)
  
        expect(establishment_2.valid?).to be(false)
        expect(establishment_2.errors.full_messages).to include('Email já está em uso')
      end

      it 'Telefone' do
        user_1 = create_owner(name: 'Andre')
        Establishment.create!(corporate_name: 'Distribuidora Alimentícia Ifood', brand_name: 'Ifood', 
                              restration_number: '17659527000125', full_address: 'Av Presindete Cabral', 
                              phone_number: '11981545874', email: 'contato@ifood.com', user: user_1)
        user_2 = create_secondary_owner(name: 'Thiago')
        establishment_2 = Establishment.new(corporate_name: 'Distribuidora Alimentícia MC Lanches', brand_name: 'MC Lanches', 
                                          restration_number: '02399570000121', full_address: 'Av São Paulo', 
                                          phone_number: '11981545874', email: 'contato@mclanches.com', user: user_2)
  
        expect(establishment_2.valid?).to be(false)
        expect(establishment_2.errors.full_messages).to include('Telefone já está em uso')
      end
    end
  end
end
