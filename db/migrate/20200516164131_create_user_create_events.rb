class CreateUserCreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_create_events do |t|
      t.references :user_change_event, null: false, foreign_key: true
      t.references :user_snap, null: false, foreign_key: true

      t.timestamps
    end
  end
end
