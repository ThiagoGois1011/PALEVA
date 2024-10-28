class ChangeColumnDayIfWeekFromOpeningHours < ActiveRecord::Migration[7.2]
  def change
    change_column_null :opening_hours, :day_of_week, false
  end
end
