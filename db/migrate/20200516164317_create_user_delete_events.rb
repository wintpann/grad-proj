class CreateUserDeleteEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_delete_events do |t|
      t.references :user_change_event, null: false, foreign_key: true
      t.references :user_snap, null: false, foreign_key: true
      t.bigint :editor_id

      t.timestamps
    end
  end
end
