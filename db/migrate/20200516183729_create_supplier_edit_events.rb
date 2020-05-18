class CreateSupplierEditEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_edit_events do |t|
      t.references :supplier_change_event, null: false, foreign_key: true
      t.bigint :from_snap_id
      t.bigint :to_snap_id
      t.bigint :editor_id

      t.timestamps
    end
  end
end
