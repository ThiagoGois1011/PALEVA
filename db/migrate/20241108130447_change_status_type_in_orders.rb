class ChangeStatusTypeInOrders < ActiveRecord::Migration[7.2]
  def change
    change_column :orders, :status, :integer, default: 0
  end
end
