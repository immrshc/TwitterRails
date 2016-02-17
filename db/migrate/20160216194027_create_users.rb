class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	  t.string :user_token, null: false
	  t.string :username, null: false
	  t.string :icon_image_url
	  t.string :hashed_password, null: false
	  t.string :email, null: false
    t.timestamps null: false
  end

    add_index :users, :user_token, unique: true
    
  end
end
