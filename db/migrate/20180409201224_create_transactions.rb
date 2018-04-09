class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
    	t.belongs_to :showing
    	t.integer :quantity
    	t.string :email
    	t.string :name
    end
  end
end
