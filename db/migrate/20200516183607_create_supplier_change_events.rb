class CreateSupplierChangeEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_change_events do |t|
      t.references :head_event, null: false, foreign_key: true
      t.string :event_type

      t.timestamps
    end
  end
end
