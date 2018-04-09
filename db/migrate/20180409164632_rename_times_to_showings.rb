class RenameTimesToShowings < ActiveRecord::Migration[5.1]
  def change
  	rename_table :times, :showings
  end
end
