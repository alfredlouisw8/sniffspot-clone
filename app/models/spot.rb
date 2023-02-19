class Spot < ApplicationRecord
  has_many :reviews, dependent: :destroy

  has_many_attached :images, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

end
