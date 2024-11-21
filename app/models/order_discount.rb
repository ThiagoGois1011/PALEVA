class OrderDiscount < ApplicationRecord
  belongs_to :discount
  belongs_to :order
end
