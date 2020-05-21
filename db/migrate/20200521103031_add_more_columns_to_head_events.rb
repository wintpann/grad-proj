class AddMoreColumnsToHeadEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :head_events, :editor_id, :bigint
    add_column :head_events, :sum, :decimal, default: 0
    add_column :head_events, :goal_type, :string
    add_column :head_events, :supplier_id, :bigint
    add_column :head_events, :product_id, :bigint
  end
end
