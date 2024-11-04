require 'rails_helper'

RSpec.describe OpeningHour, type: :model do
  describe '#valid?' do
    it 'Os dias da semana não podem ter o mesmo valor' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                                full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user_id: user.id)
      hours = []
      7.times do |day| 
        hours.push(OpeningHour.create(establishment: e, open_hour: '08:00', 
                                       close_hour: '18:00', day_of_week: :monday))  
      end
      result = hours.all? {|hour| hour.valid?}
      expect(result).to be(false)
      expect(hours.last.errors.full_messages).to include('Dia da semana já está em uso')
    end

    it 'com sucesso' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                                full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user_id: user.id)
      hours = []
      7.times do |day| 
        hours.push(OpeningHour.new(establishment: e, open_hour: '08:00', 
                                       close_hour: '18:00', day_of_week: day))  
      end
      result = hours.all? {|hour| hour.valid?}
      expect(hours.length).to eq(7)
      expect(result).to be(true)
    end

    it 'o horário de abertura não pode ser depois do horário de fechamento' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                                full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user_id: user.id)
      hours = []

      7.times do |day| 
        hours.push(OpeningHour.new(establishment: e, open_hour: '16:00', 
                                       close_hour: '8:00', day_of_week: day))  
      end
      result = hours.all? {|hour| hour.valid?}
      expect(result).to be(false)
      expect(hours.first.errors.full_messages).to include('Horário de fechamento não pode ser antes do horário de abertura')
    end
  end

  describe '#closed?' do 
    it 'Mostra um comércio que ta fechado as 06:00' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                                full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '06:00')

      expect(result).to be(true)
    end

    it 'Mostra um comércio que ta fechado as 19:00' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                                full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '19:00')

      expect(result).to be(true)
    end

    it 'Mostra um comércio que ta aberto as 08:00' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                                full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '08:00')

      expect(result).to be(false)
    end

    it 'Mostra um comércio que ta aberto as 16:00' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                                full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '16:00')

      expect(result).to be(false)
    end
  end
end
