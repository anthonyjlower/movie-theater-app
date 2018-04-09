class CreateTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :times do |t|
    	t.date :date
    	t.time :time
    	t.integer :capacity
    	t.belongs_to :movie
    end
  end
end
