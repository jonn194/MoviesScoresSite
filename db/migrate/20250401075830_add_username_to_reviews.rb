class AddUsernameToReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :reviews, :username, :string
  end
end
