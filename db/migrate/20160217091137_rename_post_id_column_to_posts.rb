class RenamePostIdColumnToPosts < ActiveRecord::Migration
  def change
	  rename_column :posts, :post_id, :reply_id
  end
end
