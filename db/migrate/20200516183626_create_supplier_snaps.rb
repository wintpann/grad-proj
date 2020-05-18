class CreateSupplierSnaps < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_snaps do |t|
      t.bigint :supplier_id
      t.string :name
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
