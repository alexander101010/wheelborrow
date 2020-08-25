class Tool < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo


  validates :description, :category, :name, :price, presence: :true
  validates :description, length: {maximum: 750}
  validates :name, length: {maximum: 50}
  validates :description, length: {minimum: 50}
  validates :price, numericality: true
  validates :category, inclusion: { in: ["hand tools", "power tools", "gardening tools"],
    message: "%{value} is not a valid category" }
end
