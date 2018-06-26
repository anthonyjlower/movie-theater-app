class MoviesController < ApplicationController
	include ApplicationHelper

	def index
		@movie_list = Movie.includes(:showings).active_movie(Date.new(2018, 4 ,12), Date.new(2018, 4, 17)).uniq.map do |movie|
			{
				movie: movie,
				showings: movie.showings
			}
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@transactions = @movie.transactions.includes(:showing).map do |transaction|
			{
				trans: transaction,
				showing: transaction.showing
			}
		end
	end

end
