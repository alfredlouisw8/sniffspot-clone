class Review < ApplicationRecord
  belongs_to :spot

  validates :name, presence: true
  validates :comment, presence: true
  validates :point, presence: true, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1, only_integer: true }
end
