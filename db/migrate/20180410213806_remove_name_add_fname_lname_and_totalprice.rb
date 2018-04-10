class RemoveNameAddFnameLnameAndTotalprice < ActiveRecord::Migration[5.1]
  def change
  	remove_column :transactions, :name
  	add_column :transactions, :first_name, :string
  	add_column :transactions, :last_name, :string
  	add_column :transactions, :cost, :float
  end
end
