class ChangeMaxMoneyOfUsers < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :users, :max_money, 100000
  end
end
