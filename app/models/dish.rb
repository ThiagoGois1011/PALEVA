class Dish < ApplicationRecord
  has_one_attached :dish_picture
  validates :name, :description, presence: true
  belongs_to :establishment
end
