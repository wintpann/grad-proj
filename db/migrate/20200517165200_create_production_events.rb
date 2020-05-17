class CreateProductionEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :production_events do |t|
      t.references :head_event, null: false, foreign_key: true
      t.decimal :sum, default: 0
      t.string :event_type
      t.bigint :editor_id

      t.timestamps
    end
  end
end
