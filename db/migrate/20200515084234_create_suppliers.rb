class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
