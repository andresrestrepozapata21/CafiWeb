class AddInvoiceToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_attachment :purchases, :invoice
  end
end
