class AddStatusToBeverages < ActiveRecord::Migration[7.2]
  def change
    add_column :beverages, :status, :integer, default: 2
  end
end
