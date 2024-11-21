class Discount < ApplicationRecord
  belongs_to :establishment
  has_many :order_discounts
  has_many :portion_discounts
  has_many :orders, through: :order_discounts
  has_many :portions, through: :portion_discounts

  def valid_date(date = Date.today)
    if date >= start_date && date <= end_date
      true
    else
      false
    end
  end
end
