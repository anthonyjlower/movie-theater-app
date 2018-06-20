class Movie < ActiveRecord::Base
	validates_presence_of :title
	has_many :showings
	has_many :transactions, through: :showings
end
