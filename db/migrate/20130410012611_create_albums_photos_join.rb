class CreateAlbumsPhotosJoin < ActiveRecord::Migration
  def up
    create_table 'albums_photos', :id => false do |t|
      t.column 'album_id', :integer
      t.column 'photo_id', :integer
    end
  end

  def down
    drop_table 'albums_photos'
  end
end
