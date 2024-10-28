class AddEniqueToManyColumnInEstablishment < ActiveRecord::Migration[7.2]
  def change
    add_index :establishments, [:email, :phone_number, :restration_number, :code], unique: true
  end
end
