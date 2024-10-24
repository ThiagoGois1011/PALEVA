class OpeningHour < ApplicationRecord
  belongs_to :establishment
  enum :day_of_week, {monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6}
end
