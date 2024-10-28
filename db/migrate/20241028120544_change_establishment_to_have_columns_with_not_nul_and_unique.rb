class ChangeEstablishmentToHaveColumnsWithNotNulAndUnique < ActiveRecord::Migration[7.2]
  def change
    change_column_null :establishments, :corporate_name, false
    change_column_null :establishments, :brand_name, false
    change_column_null :establishments, :restration_number, false
    change_column_null :establishments, :full_address, false
    change_column_null :establishments, :email, false
    change_column_null :establishments, :code, false
    change_column_null :establishments, :phone_number, false
    add_index :establishments, :restration_number, unique: true
    add_index :establishments, :email, unique: true
    add_index :establishments, :phone_number, unique: true
  end
end
