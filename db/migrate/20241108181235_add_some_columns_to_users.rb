class AddSomeColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :type, :string
    add_reference :users, :establishment, null: true, foreign_key: true
    add_column :users, :pre_registration_status, :integer, default: 0
  end
end
