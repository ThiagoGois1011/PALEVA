require 'rails_helper'

RSpec.describe OrderDiscount, type: :model do
  describe '#valid?' do
    it 'Limite atingido' do
      user = create_owner(name: 'Andre')
      establishment = create_establishment(user, corporate_name: 'Distribuidora Alimentícia Ifood')
      discount = Discount.create!(establishment: establishment, name: 'Miojão Premium', start_date: '2024-11-21', end_date: '2024-11-22',
                              discount_percentage: 10, limit: 1)
      order_1 = Order.create!(name: 'João', phone_number: '11988254174', email: 'joão@email.com', cpf: '97168422014', establishment: establishment, user: user)
      order_2 = Order.create!(name: 'Thaigo', phone_number: '11988994174', establishment: establishment, user: user)
      order_discount = discount.order_discounts.create(order: order_1)
      order_discount = discount.order_discounts.new(order: order_2)

      expect(order_discount.valid?).to eq(false)
      expect(order_discount.errors.full_messages).to include('Limite de pedidos atingido')
    end
  end
end
