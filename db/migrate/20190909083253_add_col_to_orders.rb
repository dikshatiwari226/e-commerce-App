class AddColToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :contact_name, :text
    add_column :orders, :delivery_address, :text
    add_column :orders, :ccname, :text
    add_column :orders, :ccnumber, :text
    add_column :orders, :ccexpirydate, :text
  end
end
