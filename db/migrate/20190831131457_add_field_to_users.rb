class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :integer
    add_column :users, :mobile_no, :integer
    add_column :users, :image, :string
    add_column :users, :address, :string
  end
end
