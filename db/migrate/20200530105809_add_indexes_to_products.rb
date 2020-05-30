class AddIndexesToProducts < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :name
    add_index :products, :description
  end
end
