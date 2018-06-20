class Movie < ActiveRecord::Base
	validates :title, presence: true
	has_many :showings
	has_many :transactions, through: :showings
end
