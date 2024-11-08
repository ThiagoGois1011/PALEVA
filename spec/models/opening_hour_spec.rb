require 'rails_helper'

RSpec.describe OpeningHour, type: :model do
  describe '#valid?' do
    it 'Os dias da semana não podem ter o mesmo valor' do
      user = create_owner(name: 'Andre')
      e = create_establishment(user, corporate_name: 'Ifood Distribuidora')
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
      user = create_owner(name: 'Andre')
      e = create_establishment(user, corporate_name: 'Ifood Distribuidora')
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
      user = create_owner(name: 'Andre')
      e = create_establishment(user, corporate_name: 'Ifood Distribuidora')
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
      user = create_owner(name: 'Andre')
      e = create_establishment(user, corporate_name: 'Ifood Distribuidora')
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '06:00')

      expect(result).to be(true)
    end

    it 'Mostra um comércio que ta fechado as 19:00' do
      user = create_owner(name: 'Andre')
      e = create_establishment(user, corporate_name: 'Ifood Distribuidora')
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '19:00')

      expect(result).to be(true)
    end

    it 'Mostra um comércio que ta aberto as 08:00' do
      user = create_owner(name: 'Andre')
      e = create_establishment(user, corporate_name: 'Ifood Distribuidora')
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '08:00')

      expect(result).to be(false)
    end

    it 'Mostra um comércio que ta aberto as 16:00' do
      user = create_owner(name: 'Andre')
      e = create_establishment(user, corporate_name: 'Ifood Distribuidora')
      7.times do |day| 
        OpeningHour.create!(establishment: e, open_hour: '08:00', 
                            close_hour: '18:00', day_of_week: day)               
      end

      result = OpeningHour.closed?(:monday, '16:00')

      expect(result).to be(false)
    end
  end
end
