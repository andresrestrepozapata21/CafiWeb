class AddMoneyAmountToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :money_amount, :integer
  end
end
