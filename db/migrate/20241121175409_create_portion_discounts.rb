class CreatePortionDiscounts < ActiveRecord::Migration[7.2]
  def change
    create_table :portion_discounts do |t|
      t.references :discount, null: false, foreign_key: true
      t.references :portion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
