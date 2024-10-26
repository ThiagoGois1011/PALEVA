class Beverage < ApplicationRecord
  belongs_to :establishment
  has_one_attached :picture
end
