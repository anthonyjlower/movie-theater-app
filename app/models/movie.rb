class Movie < ActiveRecord::Base
	validates_presence_of :title
	has_many :showings
	has_many :transactions, through: :showings

  scope :active_movie, -> (start_date, end_date) { joins(:showings).where('showings.date >= ? AND showings.date <= ?', start_date, end_date)}
end
