class Discount < ApplicationRecord
  belongs_to :establishment
  has_many :order_discounts
  has_many :portion_discounts
  has_many :orders, through: :order_discounts
  has_many :portions, through: :portion_discounts
  validates :name, :start_date, :end_date, :discount_percentage, presence: true
  validate :validate_start_date_and_end_date

  def valid_date(date = Date.today)
    if date >= start_date && date <= end_date
      true
    else
      false
    end
  end
  private

  def validate_start_date_and_end_date
    errors.add(:base, 'Data Final não pode ser menor que a data de início.') if start_date.present? && end_date.present? &&  start_date > end_date
  end
end
