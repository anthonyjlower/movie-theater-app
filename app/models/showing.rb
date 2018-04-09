class Showing < ActiveRecord::Base
	belongs_to :movie
	has_many :transactions

end