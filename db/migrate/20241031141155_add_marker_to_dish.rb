class AddMarkerToDish < ActiveRecord::Migration[7.2]
  def change
    add_reference :dishes, :marker, null: true, foreign_key: true
  end
end
