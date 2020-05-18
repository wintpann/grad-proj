class CreateUserSnaps < ActiveRecord::Migration[6.0]
  def change
    create_table :user_snaps do |t|
      t.bigint :user_id
      t.string :identifier
      t.string :name
      t.string :lastname
      t.string :role
      t.boolean :active

      t.timestamps
    end
  end
end
