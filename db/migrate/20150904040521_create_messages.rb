class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :email
      t.string :category
      t.string :subject
      t.string :content

      t.timestamps
    end
  end
end
