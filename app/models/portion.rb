class Portion < ApplicationRecord
  belongs_to :portionable, polymorphic: true
  has_many :historicals
  has_many :order_items, as: :portion
end
