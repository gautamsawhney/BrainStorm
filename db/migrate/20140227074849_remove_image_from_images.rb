class RemoveImageFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :image
  end

  def down
    add_column :images, :image, :string
  end
end
