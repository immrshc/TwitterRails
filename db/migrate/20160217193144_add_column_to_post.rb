class AddColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :image_width, :float
    add_column :posts, :image_height, :float
  end
end
