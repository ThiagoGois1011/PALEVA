class Dish < ApplicationRecord
  has_one_attached :picture
  validates :name, :description, presence: true
  belongs_to :establishment
end
