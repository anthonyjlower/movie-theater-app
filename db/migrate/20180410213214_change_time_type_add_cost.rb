class ChangeTimeTypeAddCost < ActiveRecord::Migration[5.1]
  def change
  	add_column :showings, :price, :float
  	change_column :showings, :time, :string
  end
end
