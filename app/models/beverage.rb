class Beverage < ApplicationRecord
  belongs_to :establishment
  has_one_attached :picture
  enum :status, {disabled: 0, active: 2}

  def translated_status
    I18n.t("activerecord.attributes.beverage.status.#{status}")
  end

  def translated_name
    I18n.t("activerecord.attributes.beverage.name")
  end

  def translated_description
    I18n.t("activerecord.attributes.beverage.description")
  end
  
  def translated_calorie
    I18n.t("activerecord.attributes.beverage.calorie")
  end
end
