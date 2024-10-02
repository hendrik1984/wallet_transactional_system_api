class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :entity, polymorphic: true
  
end