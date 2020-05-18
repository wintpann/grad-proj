class CreateProductCreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :product_create_events do |t|
      t.references :product_change_event, null: false, foreign_key: true
      t.references :product_snap, null: false, foreign_key: true
      t.bigint :editor_id

      t.timestamps
    end
  end
end
