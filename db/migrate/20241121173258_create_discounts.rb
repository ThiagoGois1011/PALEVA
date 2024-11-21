class CreateDiscounts < ActiveRecord::Migration[7.2]
  def change
    create_table :discounts do |t|
      t.string :name, null: false
      t.integer :discount_percentage, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :limit
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
