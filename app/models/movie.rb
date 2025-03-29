class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :users, through: :reviews
  has_one_attached :image

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: { in: 10..1000 }
  validates :director, presence: true, length: { in: 2..50 }
  validates :genre, presence: true, length: { in: 2..50 }
  validates :rating, presence: true
  validates :image, presence: true

  def self.search_by_title(search)
        if search
          movie_title = Movie.find_by(title: search)
            if movie_title
              self.where(id: movie_title)
            else
              @movies = Movie.all
            end
        else
          @movies = Movie.all
        end
  end
end
