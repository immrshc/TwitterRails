class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
	  t.references :user, null: false
	  t.string :post_token, null: false
	  t.text :text, null: false
	  t.float :latitude
	  t.float :longitude
	  t.string :image_key
	  t.string :image_ctype
	  t.references :post
      t.timestamps null: false
    end

	add_index :posts, :post_token, unique: true
	add_index :posts, :post_id
  
  end
end
