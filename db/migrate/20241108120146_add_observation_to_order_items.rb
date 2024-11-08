class AddObservationToOrderItems < ActiveRecord::Migration[7.2]
  def change
    add_column :order_items, :observation, :string
  end
end
