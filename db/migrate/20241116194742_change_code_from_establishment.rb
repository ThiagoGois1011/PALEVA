class ChangeCodeFromEstablishment < ActiveRecord::Migration[7.2]
  def change
    add_index :establishments, :code, unique: true
  end
end
