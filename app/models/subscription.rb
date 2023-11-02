class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :customers, through: :customer_subscriptions
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas
  
  enum :frequency, { monthly: 0, weekly: 1 }
  
  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true
end
