class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :favourite_movie
      t.string :favourite_genre
      t.integer :user_id

      t.timestamps
    end
  end
end
