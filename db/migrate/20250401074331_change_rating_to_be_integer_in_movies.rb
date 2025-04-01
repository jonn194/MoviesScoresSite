class ChangeRatingToBeIntegerInMovies < ActiveRecord::Migration[8.0]
  def up
    change_column :movies, :rating, :integer
  end
  def down
    change_column :movies, :rating, :string
  end
end
