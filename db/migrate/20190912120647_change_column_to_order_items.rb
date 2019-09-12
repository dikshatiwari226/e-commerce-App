class ChangeColumnToOrderItems < ActiveRecord::Migration[5.2]
  def change
  	change_column :order_items, :price, :float
  end
end
