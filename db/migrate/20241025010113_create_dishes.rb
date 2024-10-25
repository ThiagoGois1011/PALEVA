class CreateDishes < ActiveRecord::Migration[7.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.integer :calorie

      t.timestamps
    end
  end
end
