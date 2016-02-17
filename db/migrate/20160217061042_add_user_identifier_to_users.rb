class AddUserIdentifierToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_identifier, :string, null: false
  end
end
