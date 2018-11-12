class ChangeDatatypeUsernameOfUsers < ActiveRecord::Migration[5.1]
  def up
  	change_column :users, :username, :string
  	change_column :users, :username, :string, :null => false
  end

  def down
  	remove_column :users, :username
  end
end
