class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.string :unit
      t.string :description, default: ''
      t.references :supplier
      t.decimal :price_in
      t.decimal :price_out
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :products, :code, unique: true
  end
end
