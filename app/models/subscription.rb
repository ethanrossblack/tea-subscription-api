class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true

  enum :frequency, { monthly: 0, weekly: 1 }
end
