class Beverage < ApplicationRecord
  belongs_to :establishment
  has_one_attached :beverage_picture
end
