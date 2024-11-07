require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'Nome é obrigatório' do
      user = create_user
      establishment = create_establishment_and_opening_hour(user)
      order = Order.new(name: '', phone_number: '11988254174', email: 'joão@email.com', cpf: '48393555094', establishment: establishment, user: user)

      expect(order.valid?).to eq(false)
      expect(order.errors.full_messages).to include('Nome não pode ficar em branco')
    end
  end
end
