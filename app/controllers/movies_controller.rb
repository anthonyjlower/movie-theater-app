class MoviesController < ApplicationController
	def home

	end

	def index
		@movie_list = []
		movies = Movie.all

		movies.each do |movie|
			showings = movie.showings

			screen = {movie: movie, showings: showings}
			@movie_list.push(screen)
		end
	end

end