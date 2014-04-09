class AddDataToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :data, :hstore
  end
end
