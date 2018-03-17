class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.string :location
      t.string :img_url
      t.integer :user_id
      t.timestamps

      t.timestamps
    end
  end
end
