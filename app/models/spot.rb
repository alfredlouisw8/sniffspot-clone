class Spot < ApplicationRecord
  has_many :reviews, dependent: :destroy

  has_many_attached :images, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :images, content_type: [:png, :jpg, :jpeg, :gif, :webp],
                    size: { less_than: 5.megabytes, message: "exceeds 5 MB" }

end
