class ChangeDescriptionFromMarkers < ActiveRecord::Migration[7.2]
  def change
    change_column_null :markers, :description, false
  end
end
