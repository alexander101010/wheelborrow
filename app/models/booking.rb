class Booking < ApplicationRecord
  belongs_to :tool
  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["pending", "accepted", "denied"],
    message: "%{value} is not a valid status" }
end
