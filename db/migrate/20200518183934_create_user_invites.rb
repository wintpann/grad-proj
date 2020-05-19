class CreateUserInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :user_invites do |t|
      t.string :invite

      t.timestamps
    end
    add_index :user_invites, :invite
  end
end
