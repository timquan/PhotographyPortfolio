class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :description
      t.string :cover_pic

      t.timestamps
    end
  end
end
