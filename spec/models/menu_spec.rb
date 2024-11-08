require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe '#valid?' do
    it 'Nome é obrigatório' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      menu = Menu.new(name: '', establishment: establishment)

      expect(menu.valid?).to eq(false)
      expect(menu.errors.full_messages).to include('Nome não pode ficar em branco')
    end

    it 'Nome deve ser único dentro do estabelecimento' do
      user = create_owner(name: 'João')
      establishment = create_establishment_and_opening_hour(user, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                            open_hour: '08:00', close_hour: '18:00')
      menu_1 = Menu.create!(name: 'Almoço', establishment: establishment)
      menu_2 = Menu.new(name: 'Almoço',  establishment: establishment)

      expect(menu_2.valid?).to eq(false)
      expect(menu_2.errors.full_messages).to include('Nome já está em uso')
    end

    it 'Nome pode ser igual em estabelecimento diferentes' do
      user_1 = create_owner(name: 'João')
      user_2 = create_secondary_owner(name: 'Thiago')
      establishment_1 = create_establishment_and_opening_hour(user_1, corporate_name: 'Distribuidora Alimentícia Ifood', 
                                                              open_hour: '08:00', close_hour: '18:00')
      establishment_2 = create_secondary_establishment_and_opening_hour(user_2, corporate_name: 'Distribuidora Mc lanches', 
                                                                        open_hour: '08:00', close_hour: '18:00')
      menu_1 = Menu.create!(name: 'Almoço', establishment: establishment_1)
      menu_2 = Menu.new(name: 'Almoço',  establishment: establishment_2)

      expect(menu_2.valid?).to eq(true)
    end
  end
end
