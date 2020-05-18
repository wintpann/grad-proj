class CreateWarehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :warehouses do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
