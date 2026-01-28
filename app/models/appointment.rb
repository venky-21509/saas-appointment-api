class Appointment < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3 }
  validates :scheduled_at, presence: true
end
