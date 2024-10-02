class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :wallet
      t.references :entity, polymorphic: true
      t.string :transactions_type
      t.decimal :amount, precision: 10, scale: 2
      
      t.timestamps
    end
  end
end
