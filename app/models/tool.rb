class Tool < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, dependent: :destroy
  has_one_attached :photo


  validates :description, :category, :name, :price, presence: :true
  validates :description, length: {maximum: 750}
  validates :name, length: {maximum: 50}
  validates :description, length: {minimum: 50}
  validates :price, numericality: true
  validates :category, inclusion: { in: ["hand tools", "power tools", "gardening tools"],
    message: "%{value} is not a valid category" }

  include PgSearch::Model
  multisearchable against: [:name, :category, :description]

  def average_rating(tool)
    review_array = []
    tool.reviews.each { |review| review_array << review.rating }
    average_rating = review_array.sum / tool.reviews.size
  end
end
