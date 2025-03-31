class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  before_create :set_default_avatar

  def set_default_avatar
    self.favourite_movie = "-"
    self.favourite_genre = "-"
    self.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "Default_Profile.png")), filename: "Default_Profile.png", content_type: "image/png")
  end
end
