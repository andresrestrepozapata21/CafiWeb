class AddMaxMoneyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :max_money, :integer
  end
end
