class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :tools
  has_many :bookings
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
