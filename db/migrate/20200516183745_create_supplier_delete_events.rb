class CreateSupplierDeleteEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_delete_events do |t|
      t.references :supplier_change_event, null: false, foreign_key: true
      t.references :supplier_snap, null: false, foreign_key: true
      t.bigint :editor_id
      
      t.timestamps
    end
  end
end
