class Dish < ApplicationRecord
  has_one_attached :picture
  validates :name, :description, presence: true
  belongs_to :establishment
  belongs_to :marker, optional: true
  has_many :portions, as: :portionable
  enum :status, {disabled: 0, active: 2}
  has_many :menu_items, as: :item
  has_many :menus, through: :menu_items

  def translated_status
    I18n.t("activerecord.attributes.dish.status.#{status}")
  end
end
