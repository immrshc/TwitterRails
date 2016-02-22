class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
	  t.string :type, null: false
	  t.references :user, null: false
	  t.references :post, null: false
    t.timestamps null: false
  end

    add_index :responses, :type
    add_index :responses, :user_id
    add_index :responses, :post_id

  end
end
