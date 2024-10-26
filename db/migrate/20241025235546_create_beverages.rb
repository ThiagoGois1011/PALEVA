class CreateBeverages < ActiveRecord::Migration[7.2]
  def change
    create_table :beverages do |t|
      t.string :name
      t.string :description
      t.integer :calorie
      t.references :establishment, null: false, foreign_key: true
      t.boolean :alcoholic, default: false

      t.timestamps
    end
  end
end
