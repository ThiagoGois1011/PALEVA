class CreateOpeningHours < ActiveRecord::Migration[7.2]
  def change
    create_table :opening_hours do |t|
      t.references :establishment, null: false, foreign_key: true
      t.time :open_hour
      t.time :close_hour
      t.integer :day_of_week

      t.timestamps
    end
  end
end
