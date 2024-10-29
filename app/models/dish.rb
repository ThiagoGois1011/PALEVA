class Dish < ApplicationRecord
  has_one_attached :picture
  validates :name, :description, presence: true
  belongs_to :establishment
  has_many :portions, as: :portionable
  enum :status, {disabled: 0, active: 2}

  def translated_status
    I18n.t("activerecord.attributes.dish.status.#{status}")
  end

  def translated_name
    I18n.t("activerecord.attributes.dish.name")
  end

  def translated_description
    I18n.t("activerecord.attributes.dish.description")
  end
  
  def translated_calorie
    I18n.t("activerecord.attributes.dish.calorie")
  end
end
