class AddPortionableToPortions < ActiveRecord::Migration[7.2]
  def change
    add_reference :portions, :portionable, polymorphic: true, null: false
  end
end
