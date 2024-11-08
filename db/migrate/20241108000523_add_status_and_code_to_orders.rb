class AddStatusAndCodeToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :code, :string
    add_column :orders, :status, :string, default: 0
  end
end
