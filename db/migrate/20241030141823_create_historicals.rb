class CreateHistoricals < ActiveRecord::Migration[7.2]
  def change
    create_table :historicals do |t|
      t.datetime :date_of_change, null: false
      t.decimal :price, precision: 15, scale: 2, null: false
      t.references :portion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
