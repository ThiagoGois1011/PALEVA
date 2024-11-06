class Menu < ApplicationRecord
  validates :name, presence:true
  has_many :menu_items
  has_many :dishes, through: :menu_items, source: :item, source_type: 'Dish'
  has_many :beverages, through: :menu_items, source: :item, source_type: 'Beverage'
end
