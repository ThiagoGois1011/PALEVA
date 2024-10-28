require 'rails_helper'

RSpec.describe OpeningHour, type: :model do
  describe '#closed?' do 
    it 'Mostra um comércio que ta fechado' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                            full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                            code: '45668', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '06:00')

      expect(result).to be(true)
    end

    it 'Mostra um comércio que ta fechado. pt. 2' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                            full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                            code: '45668', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '19:00')

      expect(result).to be(true)
    end

    it 'Mostra um comércio que ta aberto' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                            full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                            code: '45668', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '08:00')

      expect(result).to be(false)
    end

    it 'Mostra um comércio que ta aberto. pt. 2' do
      user = User.create!(name: 'Andre', last_name: 'Silva Lopes', cpf: '44749124621', email: 'andre@email.com', password: 'password5498')
      e = Establishment.create!(corporate_name: 'Ifood Distribuidora', brand_name: 'Ifood', restration_number: CNPJ.generate,
                            full_address: 'Av Presidente Medice', phone_number: '11981546985', email: 'contato@ifood.com',
                            code: '45668', user_id: user.id)
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '16:00')

      expect(result).to be(false)
    end
  end
end
