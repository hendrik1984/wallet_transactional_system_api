class Wallet < ApplicationRecord
  has_many :transactions
  
  validates :name, presence: true
  validates :name, uniqueness: true
end