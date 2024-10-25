class AddEstablishmentToDishes < ActiveRecord::Migration[7.2]
  def change
    add_reference :dishes, :establishment, null: false, foreign_key: true
  end
end
