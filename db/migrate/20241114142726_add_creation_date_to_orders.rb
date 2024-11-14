class AddCreationDateToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :creation_date, :datetime
  end
end
