class AddStripeTokenToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :stripe_token, :string
    add_column :orders, :stripe_token_type, :string
    add_column :orders, :stripe_email, :string
  end
end
