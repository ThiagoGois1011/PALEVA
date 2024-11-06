class Menu < ApplicationRecord
  validates :name, presence:true
  belongs_to :establishment
  has_many :menu_items
  has_many :dishes, through: :menu_items, source: :item, source_type: 'Dish'
  has_many :beverages, through: :menu_items, source: :item, source_type: 'Beverage'
  before_validation :validate_uniqueness_of_name, on: :create


  private 

  def validate_uniqueness_of_name
    errors.add(:name, 'já está em uso') if Establishment.find(establishment_id).menus.where(name: name).any?
  end 
end
