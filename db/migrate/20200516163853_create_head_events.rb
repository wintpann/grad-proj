class CreateHeadEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :head_events do |t|
      t.string :event_type

      t.timestamps
    end
  end
end
