class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :identifier
      t.string :name
      t.string :lastname
      t.string :password_digest
      t.string :remember_digest
      t.string :role, default: 'none'
      t.boolean :active, default: true
      t.datetime :last_seen, default: Time.now

      t.timestamps
    end
    add_index :users, :identifier, unique: true
  end
end
