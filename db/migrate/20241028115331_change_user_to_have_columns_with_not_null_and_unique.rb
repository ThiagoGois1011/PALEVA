class ChangeUserToHaveColumnsWithNotNullAndUnique < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :cpf, false
    change_column_null :users, :name, false
    change_column_null :users, :last_name, false
    add_index :users, :cpf, unique: true
  end
end
