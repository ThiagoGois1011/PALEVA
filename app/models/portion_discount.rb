class PortionDiscount < ApplicationRecord
  belongs_to :discount
  belongs_to :portion
end
