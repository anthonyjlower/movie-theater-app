class MoviesController < ApplicationController
	
	def index
		@movie_list = []

		Movie.all.each do |movie|
			showings = movie.showings

			screen = {movie: movie, showings: showings}
			@movie_list.push(screen)
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@transactions = []

		@movie.transactions.each do |transaction|
			showing = transaction.showing

			resp = {
				trans: transaction,
				showing: showing
			}
			@transactions.push(resp)
		end
	end

end