class CreateRefundEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :refund_events do |t|
      t.references :production_event, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :product_snap, null: false, foreign_key: true
      t.float :amount
      t.decimal :sum, default: 0

      t.timestamps
    end
  end
end
