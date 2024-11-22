class Portion < ApplicationRecord
  belongs_to :portionable, polymorphic: true
  has_many :historicals
  has_many :order_items, as: :portion
  validates :description, :price, presence: true
  has_many :portion_discounts
  has_many :discounts, through: :portion_discounts


  def get_discount(date = Date.today)
    if discounts.any?
      bigger_discount = 0
      discounts.each do |discount|
        next if discount.limit.present? && discount.limit <= discount.order_discounts.length
        if discount.valid_date(date) && discount.discount_percentage > bigger_discount
          bigger_discount = discount.discount_percentage
        end
      end

      price * ((100 - bigger_discount) / 100.0) 
    else
      0
    end
  end
end
