class OrderDiscount < ApplicationRecord
  belongs_to :discount
  belongs_to :order
  before_validation :validate_limit, on: :create

  private 

  def validate_limit
    errors.add(:base, 'Limite de pedidos atingido') if discount.order_discounts.length - 1 == discount.limit
  end
end
