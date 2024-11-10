class Beverage < ApplicationRecord
  belongs_to :establishment
  has_one_attached :picture
  enum :status, {disabled: 0, active: 2}
  has_many :portions, as: :portionable
  has_many :menu_items, as: :item
  has_many :menus, through: :menu_items
  
  def translated_status
    I18n.t("activerecord.attributes.beverage.status.#{status}")
  end
end
