class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :director
      t.string :genre
      t.string :movie_length
      t.string :rating
      t.integer :user_id

      t.timestamps
    end
  end
end
