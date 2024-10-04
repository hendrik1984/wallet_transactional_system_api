class AddColumnMessageToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :message, :string
  end
end
