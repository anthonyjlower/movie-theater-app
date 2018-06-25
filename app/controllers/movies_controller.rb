class MoviesController < ApplicationController
	include ApplicationHelper

	def index
		@movie_list = Movie.all.includes(:showings).map do |movie|
			screen = {movie: movie, showings: movie.showings}
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@transactions = @movie.transactions.includes(:showing).map do |transaction|
			resp = {
				trans: transaction,
				showing: transaction.showing
			}
		end
	end

end
