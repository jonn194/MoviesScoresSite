class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, presence: true
  validates :comment, presence: true, length: { maximum: 1000 }
end
