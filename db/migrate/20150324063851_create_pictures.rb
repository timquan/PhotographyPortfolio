class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :description
      t.string :url_link
      t.integer :album_id

      t.timestamps
    end
  end
end
