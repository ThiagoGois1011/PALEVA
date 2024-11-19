class AddEstablishmentToMarker < ActiveRecord::Migration[7.2]
  def change
    add_reference :markers, :establishment, null: false, foreign_key: true
  end
end
