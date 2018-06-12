class MoviesController < ApplicationController

	def index
		@movie_list = Movie.all.includes(:showings).map do |movie|
			showings = movie.showings
			screen = {movie: movie, showings: showings}
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@transactions = @movie.transactions.map do |transaction|
			showing = transaction.showing
			resp = {
				trans: transaction,
				showing: showing
			}
		end
	end

end
