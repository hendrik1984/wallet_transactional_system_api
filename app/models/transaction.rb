class Transaction < ApplicationRecord
  belongs_to :wallet

  validates :wallet_id, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :amount, numericality: true
  # validates :transactions_type, presence: true, inclusion: { in: %w["Credit" "Withdraw"], message: "%{value} is not a valid transaction type" }

  validate :amount_types_process

  private
  def amount_types_process
    if transactions_type == 'Withdraw'
      self.amount = -amount
    elsif transactions_type == 'Credit'
      self.amount = amount
    else
      errors.add(:type, "is invalid")
    end
  end
end