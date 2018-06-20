class Showing < ActiveRecord::Base
	belongs_to :movie
	has_many :transactions
  validates_presence_of :date, :time, :capacity, :price
end
