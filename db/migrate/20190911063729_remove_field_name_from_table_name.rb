class RemoveFieldNameFromTableName < ActiveRecord::Migration[5.2]
  def change
  	remove_column :carts, :is_done
  	add_column :carts, :is_done, :boolean, :default => false
  end
end
