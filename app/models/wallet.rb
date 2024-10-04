class Wallet < ApplicationRecord
  has_many :transactions
  
  validates :name, presence: true
  validates :name, uniqueness: true

  def deposit(amount, message)
    return self.transactions.create!(wallet_id: self.id, amount: amount, transactions_type: "Credit", message: message)
  end

  def withdraw(amount, message)
    return self.transactions.create!(wallet_id: self.id, amount: amount, transactions_type: "Withdraw", message: message)
  end


end