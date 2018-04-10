class ChangeCostAndPriceToFloat < ActiveRecord::Migration[5.1]
  def change
  	change_column :showings, :price, :float
  	change_column :transactions, :cost, :float
  end
end
