class Transaction < ApplicationRecord
  # relationships
  belongs_to :wallet

  # validations
  validates :amount, presence: true, numericality: { greater_than: 0}
  validates :amount, numericality: true

  # custom validations
  validate :amount_types_process
  validate :safe_message
  before_save :check_balance
  after_save :calculate_balance

  private

  def safe_message
    self.message = CGI.escapeHTML(message)
  end

  def amount_types_process
    if transactions_type == 'Withdraw'
      self.amount = -amount
      check_balance
    elsif transactions_type == 'Credit'
      self.amount = amount
    else
      errors.add(:type, "is invalid")
    end
  end

  def check_balance
    if self.transactions_type == 'Withdraw'
      if (wallet.balance + self.amount) < 0
        raise 'Balance Insufficient'
      end
    end
  end

  def calculate_balance
    wallet.update!(balance: wallet.transactions.sum(:amount))
  end
end