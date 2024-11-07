class Order < ApplicationRecord
  belongs_to :establishment
  belongs_to :user
  validates :name, presence: true
end
