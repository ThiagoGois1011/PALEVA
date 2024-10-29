class CreatePortions < ActiveRecord::Migration[7.2]
  def change
    create_table :portions do |t|
      t.string :description , null: false
      t.decimal :price, precision: 15, scale: 2, null: false

      t.timestamps
    end
  end
end
