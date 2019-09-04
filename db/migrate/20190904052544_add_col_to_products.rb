class AddColToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :full_price, :float
  end
end
