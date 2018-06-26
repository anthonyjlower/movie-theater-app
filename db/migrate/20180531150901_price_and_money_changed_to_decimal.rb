class PriceAndMoneyChangedToDecimal < ActiveRecord::Migration[5.1]
  def change
  	change_column :showings, :price, :decimal
  	change_column :transactions, :cost, :decimal
  end
end
