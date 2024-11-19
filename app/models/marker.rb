class Marker < ApplicationRecord
  has_many :dishes
  belongs_to :establishment
  validates :description, presence: true 
end
