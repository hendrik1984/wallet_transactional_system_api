class Entity < ApplicationRecord
  has_one :wallet, dependent: :destroy
  accepts_nested_attributes_for :wallet

  after_create :create_wallet

  private

  def create_wallet
    wallets.create
  end

end