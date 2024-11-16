class ChangeSomeColumnFromBeverage < ActiveRecord::Migration[7.2]
  def change
    change_column_null :beverages, :name, false
    change_column_null :beverages, :description, false
    change_column_null :beverages, :alcoholic, false
  end
end
