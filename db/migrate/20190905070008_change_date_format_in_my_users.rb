class ChangeDateFormatInMyUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :mobile_no, :string
  end
end
