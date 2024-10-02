class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :type
      t.string :name
      t.decimal :balance, default: 0.0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
