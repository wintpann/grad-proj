class CreateProductSnaps < ActiveRecord::Migration[6.0]
  def change
    create_table :product_snaps do |t|
      t.bigint :product_id
      t.string :code
      t.string :name
      t.string :unit
      t.boolean :active
      t.string :description
      t.bigint :supplier_id
      t.string :supplier_name
      t.decimal :price_in
      t.decimal :price_out

      t.timestamps
    end
  end
end
