class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :customers, through: :customer_subscriptions
  
  enum :frequency, { monthly: 0, weekly: 1 }
  
  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true
end
