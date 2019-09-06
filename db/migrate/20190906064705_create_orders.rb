class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :cart_id
      t.integer :total
      t.string :status

      t.timestamps
    end
  end
end
