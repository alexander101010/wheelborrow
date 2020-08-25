class Booking < ApplicationRecord
  belongs_to :tool
  belongs_to :user

  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["pending", "accepted", "denied"],
    message: "%{value} is not a valid status" }

  def get_user
    user.first_name
  end
end
